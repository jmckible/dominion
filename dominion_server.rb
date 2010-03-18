$:.unshift File.join(File.dirname(__FILE__),'lib')

# Engine
require 'dominion'

# Gems
require 'rubygems'
require 'thin'
require 'usher'
require 'tilt'
require 'haml'

# Framework
require 'cramp/controller'
require 'active_support/all'
require 'active_support/json'

# App
require 'config/routes'
require 'app/helpers/application'
require 'app/controllers/application_controller'
require 'app/controllers/home_controller'
require 'app/controllers/start_controller'

Cramp::Controller::Websocket.backend = :thin
Thin::Logging.trace = true
Rack::Handler::Thin.run routes, :Port=>3000