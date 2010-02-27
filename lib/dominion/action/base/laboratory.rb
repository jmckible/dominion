module Dominion
  class Laboratory < Action
    
    def cost() 5            end
    def to_s() 'Laboratory' end
      
    def play(turn)
      turn.draw 2
      turn.add_action
    end
    
  end
end