module Dominion
  module Engine
    class Mine < Action
      
      def cost() 5      end
      def to_s() 'Mine' end
        
      def play(turn)
        trash = turn.select_card turn.player.hand.treasures, 'Choose a card to trash'
        if trash
          turn.broadcast "#{turn.player} trashed a #{trash}"
          turn.trash trash
          card = turn.select_card turn.game.buyable(trash.cost + 3).treasures, 'Choose a card to put in your hand'
          if card
            turn.broadcast "#{turn.player} selected a #{card}"
            turn.take card
          end
        end
      end
        
    end
  end
end