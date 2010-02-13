module Dominion
  module Engine
    class Treasure < Card
      def <=>(other)
        if other.is_a?(Action)
          1
        elsif other.is_a?(Treasure)
          value <=> other.value
        else
          -1
        end
      end
    end
  end
end

require 'dominion/engine/treasure/copper'
require 'dominion/engine/treasure/gold'
require 'dominion/engine/treasure/silver'