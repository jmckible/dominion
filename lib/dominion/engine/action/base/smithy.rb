module Dominion
  module Engine
    class Smithy < Action
      def cost() 4 end
      def name() 'Smithy' end
        
      def play(turn)
        turn.draw 3
      end
    end
  end
end