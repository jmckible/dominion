module Dominion
  class Woodcutter < Action
    
    def cost() 3            end
    def to_s() 'Woodcutter' end
      
    def play(turn)
      turn.add_buy
      turn.add_treasure 2
    end
    
  end
end