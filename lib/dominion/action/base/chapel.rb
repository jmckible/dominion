module Dominion
  
  ###########################################################################
  #                                A C T I O N                              #
  ###########################################################################
  class Chapel < Action
    def cost() 2        end
    def to_s() 'Chapel' end
      
    def play(turn)
      cards = turn.player.chapel_cards
      cards.each do |card|
        turn.trash card
      end
      turn.broadcast "#{turn.player} trashed #{cards}"
    end
  end
  
  ###########################################################################
  #                                 P L A Y E R                             #
  ###########################################################################
  class Player
    def chapel_cards
      []
    end
  end
  
  ###########################################################################
  #                                 H U M A N                               #
  ###########################################################################
  class Human < Player
    def chapel_cards
      cards = []
      
      1.upto(4) do
        card = select_card hand, :message=>'Choose a card to trash'
        break if card.nil?
        cards << card
        hand.delete card
      end
      
      cards
    end
  end
  
end