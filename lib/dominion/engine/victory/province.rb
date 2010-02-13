module Dominion
  module Engine
    class Province < Victory
      
      def cost()             8 end
      def points(player=nil) 6 end
      def to_s() 'Province'    end
        
    end
  end
end