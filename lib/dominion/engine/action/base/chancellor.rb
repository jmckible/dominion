module Dominion
  module Engine
    class Chancellor < Action
      
      def cost() 3            end
      def to_s() 'Chancellor' end
        
      def play(turn)
        turn.add_treasure 2
        turn.player.discard_deck if turn.player.get_boolean('Would you like discard your deck?')
      end
      
    end
  end
end