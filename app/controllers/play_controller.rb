class PlayController < ApplicationController
  attr_accessor :game_id, :uuid, :queue
  
  def respond_with
    [200, {'Content-Type'=>'text/html'}]
  end
  
  def start
    @game_id = params[:game_id]
    @uuid = params[:uuid]
    
    render Tilt::HamlTemplate.new('app/views/play.haml').render(self)
    finish
  end
  
end