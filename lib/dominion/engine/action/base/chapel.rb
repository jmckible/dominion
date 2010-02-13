module Dominion
  module Engine
    class Chapel < Action
      def cost() 2 end
      def name() 'Chapel' end
        
      def play(turn)
        1.upto(4) do
          puts '0. Done' unless turn.game.silent
          turn.list_hand
          choice = Game.get_integer 'Choose card to trash', 0, turn.player.hand.size
          return if choice == 0
          card = turn.player.hand[choice - 1]
          turn.trash card
          puts "Trashed #{card}" unless turn.game.silent
        end
      end
        
    end
  end
end