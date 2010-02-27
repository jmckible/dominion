module Dominion
  class Cellar < Action
    
    def cost() 2        end
    def to_s() 'Cellar' end
      
    def play(turn)
      player = turn.player
      draws = 0
      while !player.hand.empty?
        player.say_card_list player.hand
        choice = player.get_integer 'Choose card to discard', 0, player.hand.size
        break if choice == 0
        card = player.hand[choice - 1]
        player.discard_card card
        turn.broadcast "Discarded #{card}"
        draws = draws + 1
      end
      turn.draw draws
      turn.add_action
    end
    
  end
end