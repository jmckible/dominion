module Dominion
  ###########################################################################
  #                                A C T I O N                              #
  ###########################################################################
  class Chancellor < Action
    def cost() 3            end
    def to_s() 'Chancellor' end
      
    def play(turn)
      turn.add_treasure 2
      turn.player.discard_deck if turn.player.use_chancellor?(self)
    end
  end
  
  ###########################################################################
  #                                 P L A Y E R                             #
  ###########################################################################
  class Player
    def use_chancellor?(turn)
      true 
    end
  end
  
  ###########################################################################
  #                                 H U M A N                               #
  ###########################################################################
  class Human < Player
    def use_chancellor?(turn)
      get_boolean 'Would you like discard your deck?'
    end
  end
  
end