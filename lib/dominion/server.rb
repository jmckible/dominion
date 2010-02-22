require 'socket'

module Dominion
  class Server
    
    attr_accessor :match, :number_players, :server, :sockets, :message, :kingdoms
    
    ###########################################################################
    #                                 S E T U P                               #
    ###########################################################################
    def initialize(port=8000)
      @server   = TCPServer.new '', port
      @sockets  = []
      @kingdoms = []
      puts "Server started on port #{port}"
    end
    
    def setup
      @match = Match.new :server=>self
      puts "How many players? (2-#{Game.max_players})"
      @number_players = gets.chomp.to_i
      puts "Ready to play a #{number_players} game."
      self
    end
    
    ###########################################################################
    #                                   P L A Y                               #
    ###########################################################################
    def run
      trap('EXIT'){ server.close }
      puts "Collecting players"
      collect_players
      broadcast("Ready to play with #{match.players.join(', ')}") unless match.players.empty?
      play = true
      while play
        broadcast 'Choosing Kingdoms for this game'
        choose_kingdoms
        @match.use = kingdoms
        scoreboard = match.play
        broadcast "\nGame Over\n#{scoreboard}\n"
        broadcast "Waiting for server to play again\n"
        puts "Play again? (y/N)"
        play = gets.chomp.downcase == 'y'
        @kingdoms = []
      end
      broadcast match
    end
    
    def collect_players
      trap('INT'){ exit }
      while match.players.size < number_players
        response = select [@server], nil, nil, nil
        add_player unless response.nil?
      end
    end
    
    def add_player
      socket = @server.accept
      @sockets << socket unless @sockets.include?(socket)
      socket.puts "#{match.players.join(', ')} are already seated in this #{number_players} player game"
      socket.puts "What's your name?"
      name = socket.gets.chomp
      player = Player.new name, socket
      match.players << player
      broadcast "#{player} joined the game"
      puts "#{player} joined the game"
    end
    
    def choose_kingdoms
      puts 'Choose Kingdoms for this game'
      while true
        say_available_kingdoms
        choice = gets.chomp.to_i
        return if choice == 0
        kingdom = Game.available_kingdoms(:except=>kingdoms)[choice - 1]
        @kingdoms << kingdom
        broadcast "Selected Kingdoms: #{kingdoms.collect{|k|k.new.to_s}.join ', '}"
      end
    end

    def say_available_kingdoms
      puts '0. Done'
      Game.available_kingdoms(:except=>kingdoms).each_with_index do |k, i|
        puts "#{i+1}. #{k.new.to_s}"
      end
    end
    
    ###########################################################################
    #                              A I    P L A Y E R S                       #
    ###########################################################################
    # Seat BigMoney at the table
    def big_money
      match.players << BigMoney.new('Big Money')
      self
    end
    
    # Seat Highlander at the table
    def highlander
      highlander = Highlander.new('Highlander')
      highlander.wants = [Chancellor, Smithy, Festival, CouncilRoom, Laboratory]
      match.players << highlander
      self
    end
    
    ###########################################################################
    #                                    I  /  O                              #
    ###########################################################################
    def broadcast(message)
      sockets.each{|d| d.puts message}
    end
    
  end
end