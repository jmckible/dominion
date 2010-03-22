$:.unshift File.join(File.dirname(__FILE__),'lib')

# Engine
require 'dominion'

# Gems
require 'rubygems'
require 'thin'
require 'usher'
require 'tilt'
require 'haml'
require 'uuid'

# Framework
require 'cramp/controller'
require 'active_support/all'
require 'active_support/json'

# App
require 'app/helpers/application'
require 'app/controllers/application_controller'
require 'app/controllers/home_controller'
require 'app/controllers/play_controller'
require 'app/controllers/socket_controller'
require 'app/controllers/start_controller'

require 'app/models/action_loop'
require 'app/models/buy_loop'

Cramp::Controller::Websocket.backend = :thin
#Thin::Logging.trace = true

# Handle children
trap('EXIT') do
  ApplicationController.reap
  exit
end

# Middleware
use Rack::Session::Cookie
use Rack::ShowExceptions
use Rack::CommonLogger

# Routes
routes = Usher::Interface.for(:rack) do
  get('/').to(HomeController)
  post('/start').to(StartController)
  get('/games/:game_id/players/:uuid').to(PlayController)
  get('/games/:game_id/players/:uuid/socket').to(SocketController)
end

file_server = Rack::File.new(File.join(File.dirname(__FILE__), '/public/'))

run Rack::Cascade.new([routes, file_server])