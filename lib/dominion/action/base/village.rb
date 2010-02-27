module Dominion
  class Village < Action
    
    def cost() 3         end
    def to_s() 'Village' end
      
    def play(turn)
      turn.add_actions 2
      turn.draw
    end
    
  end
end