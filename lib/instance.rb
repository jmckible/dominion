class Instance
  attr_accessor :game, :socket, :number_players
  
  def initialize(options={})
    @number_players = options[:number_players]
  end
  
  def start
    read, @socket = IO::pipe
    @game = Dominion::Game.new :instance=>self, :socket=>read, :number_players=>number_players
    fork { game.start }
  end
  
  def send(params)
    if game.seating?
      socket.puts params['player_name']
    else
      puts "game not seating"
    end
  end
  
  def broadcast(message)
    puts message
  end
  
end