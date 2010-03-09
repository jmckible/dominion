$:.unshift File.join(File.dirname(__FILE__),'lib')

require 'server'

use Rack::ShowExceptions
run Server.new