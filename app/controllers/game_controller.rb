class GameController < WebSocketApplicationController
  
  def start
    render params.to_a.collect{|i| "<p>#{i.first}: #{i.last}</p>"}
    finish
  end
  
end