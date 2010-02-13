module Dominion
  module Engine
    class Estate < Victory
      
      def cost()             2 end
      def points(player=nil) 1 end
      def name() 'Estate'      end
      
    end
  end
end