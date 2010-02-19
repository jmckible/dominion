module Dominion
  module Engine
    class Spy < Action
      
      def cost() 4     end
      def to_s() 'Spy' end
        
      def play(turn)
        turn.draw
        turn.add_action
        
        turn.other_players.each do |player|
          turn.player.spy_on player
        end

        turn.player.spy_on turn.player
        
      end
        
    end
  end
end