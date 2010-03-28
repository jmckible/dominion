class StartController < ApplicationController
  before_start :start_game
  
  def start_game    
    id = @@counter += 1
    @@games[id] = Dominion::Game.new :id=>id
    @@games[id].start
    
    uuid = UUID.new.generate
    user_options = {:uuid=>uuid, :name=>request.params['name']}
    @@games[id].notify user_options
    
    # Initialize queues
    @game_queue   = MQ.queue "game-#{id}"
    @player_queue = MQ.queue "player-#{uuid}"
    
    halt 302, {'Location'=>"games/#{id}/players/#{uuid}"}
  end
  
end