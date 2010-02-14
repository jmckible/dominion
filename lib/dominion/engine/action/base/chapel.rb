module Dominion
  module Engine
    class Chapel < Action
      
      def cost() 2        end
      def to_s() 'Chapel' end
        
      def play(turn)
        1.upto(4) do
          turn.player.say '0. Done' 
          turn.say_card_list turn.player.hand
          choice = turn.player.get_integer 'Choose card to trash', 0, turn.player.hand.size
          return if choice == 0
          card = turn.player.hand[choice - 1]
          turn.trash card
          turn.broadcast "Trashed #{card}"
        end
      end
        
    end
  end
end