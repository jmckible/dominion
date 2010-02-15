module Dominion
  module Engine
    class Moneylender < Action
      
      def cost() 4             end
      def to_s() 'Moneylender' end
        
      def play(turn)
        copper = turn.player.hand.detect{|card|card.is_a? Copper}
        if copper
          trash = turn.player.get_boolean "Do you want to trash a Copper for $3?"
          if trash
            turn.trash copper
            turn.add_treasure 3
            turn.broadcast "#{turn.player} trashed a Copper to gain $3"
          end
        end
      end
        
    end
  end
end