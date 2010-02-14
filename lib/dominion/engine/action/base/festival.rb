module Dominion
  module Engine
    class Festival < Action
      
      def cost() 5          end
      def to_s() 'Festival' end
        
      def play(turn)
        turn.add_actions 2
        turn.add_buy
        turn.add_treasure 2
      end
      
    end
  end
end