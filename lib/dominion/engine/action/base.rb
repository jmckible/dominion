module Dominion
  module Engine
    module Base
      def self.available_kingdoms
        #[ Adventurer, Bureaucrat, Cellar, Chancellor, Chapel, CouncilRoom,
        #  Feast, Festival, Gardens, Laboratory, Library, Market, Militia,
        #  Mine, Moat, Moneylender, Remodel, Smithy, Spy, Thief, ThroneRoom,
        #  Village, Witch, Woodcutter, Workshop ]
        [ Cellar, Chancellor, Chapel, CouncilRoom, Feast, Festival, Laboratory, 
          Market, Smithy, Village, Woodcutter, Workshop ]
      end
    end
  end
end

require 'dominion/engine/action/base/adventurer'
require 'dominion/engine/action/base/bureaucrat'
require 'dominion/engine/action/base/cellar'
require 'dominion/engine/action/base/chancellor'
require 'dominion/engine/action/base/chapel'
require 'dominion/engine/action/base/council_room'
require 'dominion/engine/action/base/feast'
require 'dominion/engine/action/base/festival'
require 'dominion/engine/action/base/laboratory'
require 'dominion/engine/action/base/library'
require 'dominion/engine/action/base/market'
require 'dominion/engine/action/base/militia'
require 'dominion/engine/action/base/mine'
require 'dominion/engine/action/base/moat'
require 'dominion/engine/action/base/moneylender'
require 'dominion/engine/action/base/remodel'
require 'dominion/engine/action/base/smithy'
require 'dominion/engine/action/base/spy'
require 'dominion/engine/action/base/thief'
require 'dominion/engine/action/base/throne_room'
require 'dominion/engine/action/base/village'
require 'dominion/engine/action/base/witch'
require 'dominion/engine/action/base/woodcutter'
require 'dominion/engine/action/base/workshop'