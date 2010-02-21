module Dominion
  module Engine
    class Witch < Action
      
      def cost() 5       end
      def to_s() 'Witch' end
        
        
      def play(turn)
        turn.player.draw 2
        turn.other_players.each do |player|
          player.gain turn.game.curses.shift
          player.say "You gained a Curse from #{turn.player}'s Witch"
        end
      end
        
    end
  end
end