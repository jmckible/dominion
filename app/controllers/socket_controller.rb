class SocketController < WebSocketApplicationController
  attr_accessor :game_id, :uuid
  
  on_data   :write_to_game
  on_finish :user_left
  
  def start    
    @game_id = params[:game_id].to_i
    @uuid = params[:uuid]
        
    queue = MQ.new
    queue.queue("game-player-#{uuid}").bind(queue.fanout("game-#{game_id}")).subscribe do |message|
      render message
    end
  end
  
  def write_to_game(data)
    @@games[game_id].notify data
  end
  
  def user_left
    # End game
  end
  
end