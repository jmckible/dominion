module Dominion
  module Engine
    class Laboratory < Action
      def cost() 5 end
        
      def play(turn)
        turn.draw_card
        turn.draw_card
        turn.add_action
      end
    end
  end
end