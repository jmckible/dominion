require 'dominion/card'
require 'dominion/action'
require 'dominion/deck'
require 'dominion/game'
require 'dominion/match'
require 'dominion/pile'
require 'dominion/scoreboard'
require 'dominion/score'
require 'dominion/turn'
require 'dominion/victory'
require 'dominion/wheel'

require 'dominion/player/player'
require 'dominion/player/big_money'
require 'dominion/player/highlander'

module Dominion
  class GameFull < Exception 
  end
  
  def self.available_sets
    [ Base, Seaside ]
  end
end