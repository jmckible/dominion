require 'dominion/action/base/adventurer'
require 'dominion/action/base/bureaucrat'
require 'dominion/action/base/cellar'
require 'dominion/action/base/chancellor'
require 'dominion/action/base/chapel'
require 'dominion/action/base/council_room'
require 'dominion/action/base/feast'
require 'dominion/action/base/festival'
require 'dominion/action/base/laboratory'
require 'dominion/action/base/library'
require 'dominion/action/base/market'
require 'dominion/action/base/militia'
require 'dominion/action/base/mine'
require 'dominion/action/base/moat'
require 'dominion/action/base/moneylender'
require 'dominion/action/base/remodel'
require 'dominion/action/base/smithy'
require 'dominion/action/base/spy'
require 'dominion/action/base/thief'
require 'dominion/action/base/throne_room'
require 'dominion/action/base/village'
require 'dominion/action/base/witch'
require 'dominion/action/base/woodcutter'
require 'dominion/action/base/workshop'

module Dominion
  module Base
    def self.available_kingdoms
      [ Adventurer, Bureaucrat, Cellar, Chancellor, Chapel, CouncilRoom, 
        Feast, Festival, Gardens, Laboratory, Library, Market, Militia, Mine, 
        Moat, Moneylender, Remodel, Smithy, Spy, Thief, ThroneRoom, Village, 
        Witch, Woodcutter, Workshop ]
    end
  end
end

