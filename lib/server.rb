# EventMachine::DelegatedHttpResponse.new
# env["PATH_INFO"] == "/favicon.ico"
#response = Rack::Response.new
#env.each do |key, value|
#  response.write "<p>#{key} [#{value.class.to_s}] #{value}</p>"
#end
#response.finish
require 'dominion'

class Server
  attr_accessor :games, :counter
  
  def initialize
    @games   = {}
    @counter = 0
  end
  
  def call(env)
    request = Rack::Request.new(env)   
    case env['PATH_INFO']
    when '/new'
      add_game
    when /\/game\/\d+/i
      id = env['PATH_INFO'].split('/').last.to_i
      games[id].puts "writing to game #{id}"
    else
      response = Rack::Response.new
      response.write 'No action taken'
      response.finish
    end
  end
  
  def add_game
    @counter += 1
    #here, there = Socket.pair Socket::AF_UNIX, Socket::SOCK_STREAM, 0
    read, write = IO::pipe
    games[counter] = write
    
    fork { Dominion::Game.new(:server=>read).start }
    
    response = Rack::Response.new
    response.write counter
    response.finish
  end

end