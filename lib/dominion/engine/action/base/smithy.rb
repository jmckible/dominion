module Dominion
  module Engine
    class Smithy < Action
      def cost() 4 end
        
      def play(turn)
        turn.draw_card 3
      end
    end
  end
end