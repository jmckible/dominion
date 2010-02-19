module Dominion
  module Engine
    class Adventurer < Action
      
      def cost() 6            end
      def to_s() 'Adventurer' end
        
        
      def play(turn)
        treasure = []
        player = turn.player
        while player.can_draw? && treasure.size < 2
          draw = player.draw.first
          player.say "Drew a #{draw}"
          if draw.is_a?(Treasure)
            treasure << draw
          else
            player.discard_card draw
          end
        end
        treasure
      end
        
    end
  end
end