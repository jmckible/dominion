require 'dominion/engine'

module Dominion
  include Dominion::Engine
  
  class GameFull < Exception 
  end
  
  def self.available_sets
    [Base]
  end
  
end

include Dominion # is this right?
