require 'dominion/engine'
require 'dominion/input'
require 'dominion/server'
require 'dominion/ai'

module Dominion
  include Dominion::Engine
  include Dominion::AI
  
  class GameFull < Exception 
  end
  
  def self.available_sets
    [Base]
  end
  
end

include Dominion # is this right?
