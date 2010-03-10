class Instance
  attr_accessor :game, :socket, :number_players
  
  def initialize(options={})
    @number_players = options[:number_players]
  end
  
  def start
    read, @socket = IO::pipe
    fork { Dominion::Game.new(:socket=>read, :number_players=>number_players).start }
  end
  
  def send(data)
    socket.puts data
  end
  
end