class StartController < ApplicationController
  before_start :start_game
  
  def start_game
    # Spawn game process
    id = @@counter += 1
    read, write = IO::pipe
    @@sockets[@@counter] = write
    @@pids << fork{ Dominion::Game.new(:socket=>read, :id=>id).start }

    # Exchange
    uuid = UUID.new.generate

    # Write to seat player
    YAML.dump params.merge('uuid'=>uuid), write
    write.write "\n...\n\n"
    
    halt 302, {'Location'=>"player/#{uuid}"}
  end

end