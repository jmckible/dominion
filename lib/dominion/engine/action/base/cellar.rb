module Dominion
  module Engine
    class Cellar < Action
      def cost() 2 end
      def to_s() 'Cellar' end
        
      def play(turn)
        draws = 0
        while !turn.player.hand.empty?
          turn.player.puts '0. Done' unless turn.game.silent
          turn.list_hand
          choice = turn.player.get_integer 'Choose card to discard', 0, turn.player.hand.size
          break if choice == 0
          card = turn.player.hand[choice - 1]
          turn.discard card
          turn.broadcast "Discarded #{card}" unless turn.game.silent
          draws = draws + 1
        end
        turn.draw draws
        turn.add_action
      end
      
    end
  end
end