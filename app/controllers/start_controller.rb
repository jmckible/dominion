class StartController < ApplicationController
  
  def start
    @@counter += 1
    read, write = IO::pipe
    @@sockets[@@counter] = write
    pid = fork { Dominion::Game.new(:socket=>read).start }
    @@pids << pid
    render @@counter
    finish
  end
  
end