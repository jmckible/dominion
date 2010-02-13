module Dominion
  module Engine
    class Market < Action
      def cost() 5 end
      def name() 'Market' end
        
      def play(turn)
        turn.draw_card
        turn.add_action
        turn.add_buy
        turn.add_treasure 1
      end
        
    end
  end
end