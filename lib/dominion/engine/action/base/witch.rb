module Dominion
  module Engine
    class Witch < Action
      
      def cost() 5       end
      def to_s() 'Witch' end
        
        
      def play(turn)
        turn.player.draw 2
        turn.other_players.each do |player|
          if player.moat?
            turn.broadcast "#{player} revealed a Moat"
          else
            curse = turn.game.curses.shift
            if curse
              player.gain curse
              player.say "You gained a Curse from #{turn.player}'s Witch"
            else
              turn.broadcast "No Moats left"
            end
          end
          
        end
      end
        
    end
  end
end