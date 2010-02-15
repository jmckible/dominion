require 'socket'

module Dominion
  class Server
    
    attr_accessor :game, :number_players, :server, :sockets, :message
    
    def initialize(port=8000)
      @server  = TCPServer.new '', port
      @sockets = []
      puts "Server started on port #{port}"
    end
    
    def setup
      @game = Game.new self
      puts "How many players? (2-#{Game.max_players})"
      @number_players = gets.chomp.to_i
      puts "Ready to play a #{number_players} game."
      self
    end
    
    # Seat BigMoney at the table
    def big_money
      game.seat BigMoney.new('Big Money')
      self
    end
    
    def run
      trap('EXIT'){ server.close }
      puts "Collecting players"
      collect_players
      broadcast "Ready to play with #{game.players.join(', ')}"
      game.play
      broadcast "Game Over, man. Game over"
    end
    
    def collect_players
      trap('INT'){ exit }
      while game.players.size < number_players
        response = select [@server], nil, nil, nil
        add_player unless response.nil?
      end
    end
    
    def add_player
      socket = @server.accept
      @sockets << socket unless @sockets.include?(socket)
      socket.puts "#{game.players.join(', ')} are already seated in this #{number_players} player game"
      socket.puts "What's your name?"
      name = socket.gets.chomp
      player = Player.new name, socket
      game.seat player
      broadcast "#{player} joined the game"
      puts "#{player} joined the game"
    end
    
    def broadcast(message)
      sockets.each{|d| d.puts message}
    end
    
  end
end