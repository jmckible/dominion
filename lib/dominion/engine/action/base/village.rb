module Dominion
  module Engine
    class Village < Action
      def cost() 3 end
        
      def play(turn)
        turn.add_action
        turn.add_action
        turn.draw_card
      end
    end
  end
end