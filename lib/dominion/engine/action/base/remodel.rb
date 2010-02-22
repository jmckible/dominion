module Dominion
  module Engine
    class Remodel < Action
      
      def cost() 4         end
      def to_s() 'Remodel' end
        
      def play(turn)
        player = turn.player
        trash = player.select_card player.hand
        if trash
          turn.broadcast "#{player} trashed a #{trash}"
          turn.trash trash
          card = player.select_card turn.game.buyable(trash.cost + 2)
          if card
            turn.broadcast "#{player} selected a #{card}"
            turn.take card
          end
        end
      end
        
    end
  end
end