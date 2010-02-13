require 'dominion/engine'
require 'dominion/input'
require 'dominion/server'

module Dominion
  include Dominion::Engine
  
  class GameFull < Exception 
  end
  
  def self.available_sets
    [Base]
  end
  
end

include Dominion # is this right?
