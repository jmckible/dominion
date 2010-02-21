module Dominion
  module Engine
    class Curse < Card
      
      def cost()             0  end
      def points(player=nil) -1 end
      def to_s() 'Curse'        end
      
    end
  end
end