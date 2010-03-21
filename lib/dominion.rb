require 'mq'

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

require 'dominion/action/base'
require 'dominion/action/seaside'

require 'dominion/curse'
require 'dominion/treasure'

require 'dominion/treasure/copper'
require 'dominion/treasure/gold'
require 'dominion/treasure/silver'

require 'dominion/victory/duchy'
require 'dominion/victory/estate'
require 'dominion/victory/gardens'
require 'dominion/victory/province'

require 'dominion/player/player'
require 'dominion/player/big_money'
require 'dominion/player/highlander'
require 'dominion/player/user'

module Dominion
  class GameFull < Exception 
  end

  def self.available_sets
    [ Base, Seaside ]
  end
end