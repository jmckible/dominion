class StartController < ApplicationController
  before_start :start_game
  
  
  def start_game
    @@counter += 1
    read, write = IO::pipe
    @@sockets[@@counter] = write
    @@pids << fork{ Dominion::Game.new(:socket=>read).start }

    YAML.dump params, write
    write.write "\n...\n\n"
    
    halt 302, {'Location'=>"game/#{@@counter}"}
  end

end