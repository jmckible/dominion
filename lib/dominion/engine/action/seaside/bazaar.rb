module Dominion
  module Engine
    class Bazaar < Action
      
      def cost() 5        end
      def to_s() 'Bazaar' end
        
      def play(turn)
        turn.player.draw
        turn.add_actions 2
        turn.add_treasure 1
      end
        
    end
  end
end