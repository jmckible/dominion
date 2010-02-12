module Dominion
  module Engine
    class Chancellor < Action
      def cost() 3 end
        
      def play(turn)
        turn.add_treasure 2
        turn.player.discard_deck if Game.get_boolean('Would you like discard your deck?')
      end
    end
  end
end