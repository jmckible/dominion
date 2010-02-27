module Dominion
  ###########################################################################
  #                                A C T I O N                              #
  ###########################################################################
  class Cellar < Action
    def cost() 2        end
    def to_s() 'Cellar' end
      
    def play(turn)
      cards = turn.player.cellar_cards
      turn.broadcast "#{turn.player} discarded #{cards}"
      turn.draw cards.size
      turn.add_action
    end
  end
  
  ###########################################################################
  #                                 P L A Y E R                             #
  ###########################################################################
  class Player
    def cellar_cards
      []
    end 
  end
  
  ###########################################################################
  #                                 H U M A N                               #
  ###########################################################################
  class Human < Player
    def cellar_cards
      cards = []
      
      while !hand.empty?
        card = select_card hand, :message=>'Choose a card to discard'
        if card
          discard_card card
          cards << card
        end
      end
      
      cards
    end
  end
  
end