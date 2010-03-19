class GameController < WebSocketApplicationController
  
  def on_start
    queue = MQ.queue "game-#{params[:id]} player-1"
    
  end
  
  def start
    render params.to_a.collect{|i| "<p>#{i.first}: #{i.last}</p>"}
    finish
  end
  
end