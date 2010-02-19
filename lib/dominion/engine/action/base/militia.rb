module Dominion
  module Engine
    class Militia < Action
      
      def cost() 4         end
      def to_s() 'Militia' end
        
      def play(turn)
        turn.add_treasure 2
        turn.other_players.each do |player|
          player.militia_discard
        end
      end
        
    end
  end
end