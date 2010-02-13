module Dominion
  module Engine
    class Village < Action
      def cost() 3 end
      def name() 'Village' end
        
      def play(turn)
        turn.add_actions 2
        turn.draw
      end
    end
  end
end