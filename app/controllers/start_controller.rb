class StartController < ApplicationController
  
  def start
    @@counter += 1
    read, write = IO::pipe
    @@sockets[@@counter] = write
    fork { Dominion::Game.new(:socket=>read).start }
    render @@counter
    finish
  end
  
end