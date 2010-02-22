module Dominion
  module Engine
    class Curse < Card
      
      def cost()             0  end
      def points(player=nil) -1 end
      def to_s() 'Curse'        end
        
      def <=>(other)
        other.is_a?(Curse) ? 1 : -1
      end
      
    end
  end
end