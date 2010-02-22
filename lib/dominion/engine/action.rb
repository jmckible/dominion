module Dominion
  module Engine
    class Action < Card
      
      def <=>(other)
        if other.is_a? Action
          to_s <=> other.to_s
        else
          -1
        end
      end
      
    end
  end
end

require 'dominion/engine/action/base'
require 'dominion/engine/action/seaside'