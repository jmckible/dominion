module Dominion
  module Engine
    module Base
      def set_name() 'Base' end
    end
  end
end

require 'dominion/engine/kingdom/base/bureaucrat'
require 'dominion/engine/kingdom/base/cellar'
require 'dominion/engine/kingdom/base/chancellor'
require 'dominion/engine/kingdom/base/chapel'
require 'dominion/engine/kingdom/base/council_room'
require 'dominion/engine/kingdom/base/village'