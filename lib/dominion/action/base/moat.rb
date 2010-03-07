module Dominion
  ###########################################################################
  #                                A C T I O N                              #
  ###########################################################################
  class Moat < Action
    def cost() 2      end
    def to_s() 'Moat' end
      
    def play(turn)
      turn.player.draw 2
    end
  end
  
  ###########################################################################
  #                                 P L A Y E R                             #
  ###########################################################################
  class Player
    # Return true to halt attack
    # Return false to continue
    def moat?
      !hand.moats.empty?
    end
  end
  
  ###########################################################################
  #                                 H U M A N                               #
  ###########################################################################
  class TerminalPlayer < Player
    def moat?
      return false if hand.moats.empty?
      get_boolean "Would you like to reveal a Moat?"
    end
  end
  
end