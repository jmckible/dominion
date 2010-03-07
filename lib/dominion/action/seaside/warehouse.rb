module Dominion
  ###########################################################################
  #                                A C T I O N                              #
  ###########################################################################
  class Warehouse < Action
    def cost() 5           end
    def to_s() 'Warehouse' end
      
    def play(turn)
      turn.player.draw 3
      turn.add_action
      discards = turn.player.warehouse_discard
      discards.each{|card| turn.player.discard_card card}
      turn.broadcast "#{turn.player} discarded #{discards}"
    end
  end
  
  ###########################################################################
  #                                 P L A Y E R                             #
  ###########################################################################
  class Player
    def warehouse_discard
      hand.first(3).compact
    end
  end
  
  ###########################################################################
  #                                 H U M A N                               #
  ###########################################################################
  class TerminalPlayer < Player
    def warehouse_discard
      discards = []
      0.upto(2) do |i|
        card = select_card hand, :message=>'Choose a card to discard', :force=>true
        discards << card
      end
      discards.compact
    end
  end
  
end