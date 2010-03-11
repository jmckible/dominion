require 'dominion'

class Server
  attr_accessor :sockets, :counter
  
  def initialize
    @sockets = {}
    @counter = 0
  end
  
  def call(env)
    request = Rack::Request.new env
    case request.path
    when '/new'
      add_game
    when '/game'
      socket = sockets[request.params['game_id'].to_i]
      if socket
        socket.puts request.params['input']
        redirect_to env['HTTP_REFERER']
      else
        respond_404
      end
    else
      respond_404
    end

  end
  
  def add_game
    @counter += 1
    read, write = IO::pipe
    sockets[counter] = write
    fork { Dominion::Game.new(:socket=>read).start }
    Rack::Response.new counter.to_s
  end

  def respond_404
    Rack::Response.new '404 not found', 404
  end
  
  def respond_env(request, env)
    response = Rack::Response.new
    response.write '<pre>'
    response.write "counter: #{counter}\n"
    response.write "requests.params [#{request.params.class}]: #{request.params}\n"
    request.params.each do |key, value|
      response.write "request['#{key}'] [#{value.class}]: #{value}\n"
    end
    env.each do |key, value|
      response.write "#{key} [#{value.class}]: #{value}\n"
    end
    response.write '</pre>'
    response.finish
  end
  
  def redirect_to(url)
    [ 302, {'Location'=>url}, [] ]
  end

end