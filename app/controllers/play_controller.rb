class PlayController < WebSocketApplicationController
  attr_accessor :game_id, :uuid, :queue
  
  on_data   :write_to_socket
  on_finish :user_left
  
  def start
    #render Erubis::Eruby.new(File.read('app/views/play.erb')).result(binding)
    
    
    
    @game_id = params[:game_id]
    @uuid = params[:uuid]
    
    render Tilt::HamlTemplate.new('app/views/play.haml').render(self)
    
    @queue = MQ.queue "game-player-#{uuid}"
    queue.bind(MQ.fanout("game-#{game_id}"))
    queue.bind(MQ.fanout("player-#{uuid}"))
    
    queue.subscribe do |message|
      puts "MQ: #{message}"
      render message
    end
  end
  
  def write_to_socket
    socket = @@sockets[params[:game_id]]
    YAML.dump params, socket
    socket.write "\n...\n\n"
  end
  
  def user_left
    # take care of business
  end
  
end