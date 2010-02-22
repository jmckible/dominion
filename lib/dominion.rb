require 'dominion/engine'
require 'dominion/ai'
require 'dominion/input'
require 'dominion/server'

module Dominion
  include Dominion::Engine
  include Dominion::AI
  
  class GameFull < Exception 
  end
  
  def self.available_sets
    [ Base, Seaside ]
  end
  
end

include Dominion # is this right?
