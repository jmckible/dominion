module Dominion
  class Moat < Action
    
    def cost() 2      end
    def to_s() 'Moat' end
      
    def play(turn)
      turn.player.draw 2
    end
      
  end
end