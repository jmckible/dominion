module Dominion
  module Engine
    class Mine < Action
      
      def cost() 5      end
      def to_s() 'Mine' end
        
      def play(turn)
        player = turn.player
        trash = player.select_card player.hand.treasures, :message=>'Choose a card to trash'
        if trash
          turn.broadcast "#{player} trashed a #{trash}"
          turn.trash trash
          card = player.select_card turn.game.buyable(trash.cost + 3).treasures, 
            :message=>'Choose a card to put in your hand'
          if card
            turn.broadcast "#{player} selected a #{card}"
            turn.take card
          end
        end
      end
        
    end
  end
end