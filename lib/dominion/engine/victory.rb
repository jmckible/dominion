module Dominion
  module Engine
    class Victory < Card
      def <=>(other)
        if other.is_a? Victory
          points <=> other.points
        else
          1
        end
      end
    end
  end
end

require 'dominion/engine/victory/duchy'
require 'dominion/engine/victory/estate'
require 'dominion/engine/victory/gardens'
require 'dominion/engine/victory/province'