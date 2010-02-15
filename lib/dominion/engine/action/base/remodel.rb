module Dominion
  module Engine
    class Remodel < Action
      
      def cost() 4         end
      def to_s() 'Remodel' end
        
      def play(turn)
        trash = turn.select_card turn.player.hand
        if trash
          turn.broadcast "#{turn.player} trashed a #{trash}"
          turn.trash trash
          card = turn.select_card turn.game.buyable(trash.cost + 2)
          if card
            turn.broadcast "#{turn.player} selected a #{card}"
            turn.take card
          end
        end
      end
        
    end
  end
end