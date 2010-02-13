module Dominion
  module Engine
    class Duchy < Victory
      
      def cost()             5 end
      def points(player=nil) 3 end
      def name() 'Duchy'       end
        
    end
  end
end