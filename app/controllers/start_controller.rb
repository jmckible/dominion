class StartController < ApplicationController
  before_start :start_game
  
  def start_game    
    id = @@counter += 1
    @@games[id] = Dominion::Game.new :id=>id
    @@games[id].start
    
    uuid = UUID.new.generate
    hash = {'uuid'=>uuid, 'name'=>'You'} 
    @@games[id].push hash
    
    halt 302, {'Location'=>"games/#{id}/players/#{uuid}"}
  end
  
end