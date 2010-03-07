module Dominion
  ###########################################################################
  #                                A C T I O N                              #
  ###########################################################################
  class Militia < Action
    def cost() 4         end
    def to_s() 'Militia' end
      
    def play(turn)
      turn.add_treasure 2
      turn.other_players.each do |player|
        discards = player.militia_discard
        if discards
          if discards.empty?
            turn.broadcast "#{player} didn't need to discard"
          else
            discards.each{|c| player.discard_card c}
            turn.broadcast "#{player} discarded #{discards.join ', '}"
          end
        else
          turn.broadcast "#{player} revealed at Moat"
        end
      end
    end
  end
  
  ###########################################################################
  #                                 P L A Y E R                             #
  ###########################################################################
  class Player
    # Return discard list on successful attack
    # Return false on unsuccessful (Moat)
    def militia_discard
      return false if moat?
      hand[3..-1]
    end
  end
  
  ###########################################################################
  #                                 H U M A N                               #
  ###########################################################################
  class TerminalPlayer < Player
    def militia_discard
      return false if moat?
      discards = []
      while hand.size > 3
        discards << select_card(player.hand, :message=>"Choose a card to discard (from #{turn.player}'s Militia)", :force=>true)
      end
      return discards
    end
  end
  
end