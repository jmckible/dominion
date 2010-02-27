module Dominion
  class Smithy < Action
    
    def cost() 4        end
    def to_s() 'Smithy' end
      
    def play(turn)
      turn.draw 3
    end
    
  end
end