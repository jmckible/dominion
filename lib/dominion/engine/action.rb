module Dominion
  module Engine
    class Action < Card
      def self.starting_count() 10 end
      def play(turn) end
        
      def <=>(other)
        if other.is_a? Action
          name <=> other.name
        else
          -1
        end
      end
    end
  end
end

require 'dominion/engine/action/base'