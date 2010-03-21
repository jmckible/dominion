class StartController < ApplicationController
  before_start :start_game
  
  def start_game
    # Spawn game process
    id = @@counter += 1
    read, write = IO::pipe
    @@sockets[id] = write
    
    pid = EM.fork_reactor { Dominion::Game.new(:socket=>read, :id=>id).start }
    Process.detach pid
    @@pids << pid

    uuid = UUID.new.generate    
    hash = {'uuid'=>uuid, 'name'=>'You'} # params.merge{:uuid=>uuid}
    Marshal.dump hash, write  
    
    halt 302, {'Location'=>"games/#{id}/players/#{uuid}"}
  end
  
end