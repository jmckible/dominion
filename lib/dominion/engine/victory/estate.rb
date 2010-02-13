module Dominion
  module Engine
    class Estate < Victory
      
      def cost()             2 end
      def points(player=nil) 1 end
      def to_s() 'Estate'      end
      
    end
  end
end