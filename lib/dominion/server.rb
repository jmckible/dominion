require 'socket'

module Dominion
  class Server
    
    attr_accessor :match, :number_players, :server, :sockets, :message
    
    ###########################################################################
    #                                 S E T U P                               #
    ###########################################################################
    def initialize(port=8000)
      @server  = TCPServer.new '', port
      @sockets = []
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
      broadcast "Ready to play with #{match.players.join(', ')}"
      play = true
      while play
        scoreboard = match.play
        broadcast "Game Over:\n#{scoreboard}\n"
        broadcast "Waiting for server to play again\n"
        puts "Play again? (y/n)"
        play = gets.chomp.downcase == 'y'
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