require 'dominion'

require 'instance'

class Server
  attr_accessor :games, :counter
  
  def initialize
    @games   = {}
    @counter = 0
  end
  
  def call(env)
    request = Rack::Request.new env
    case request.path
    when '/new'
      add_instance request.params
    when '/game'
      instance = games[request.params['game_id'].to_i]
      if instance
        instance.send request.params
        redirect_to env['HTTP_REFERER']
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
  
  def add_instance(options={})
    @counter += 1
    instance = Instance.new :number_players=>(options['players'] || 2)
    games[counter] = instance
    instance.start
    Rack::Response.new counter.to_s
  end

end