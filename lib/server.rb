require 'dominion'

class Server
  attr_accessor :games, :counter
  
  def initialize
    @games   = {}
    @counter = 0
  end
  
  def call(env)
    request = Rack::Request.new env
    case env['PATH_INFO']
    when '/new'
      add_game
    when /\/game\/\d+/
      id = env['PATH_INFO'].split('/').last.to_i
      socket = games[id]
      if socket
        socket.puts request.params
      else
        respond_404
      end
    else
      respond_404
    end
  end
  
  def respond_404
    Rack::Response.new '404 not found', 404
  end
  
  def add_game
    @counter += 1

    read, write = IO::pipe
    games[counter] = write
    process = fork { Dominion::Game.new(:socket=>read).start }
    Process.detach process
    
    Rack::Response.new counter.to_s
  end

end