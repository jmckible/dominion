module Dominion
  module Engine
    class Card
      def to_s
        self.class.name.split('::').last
      end
    end
  end
end

require 'dominion/engine/treasure'

