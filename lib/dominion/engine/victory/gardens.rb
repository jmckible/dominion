module Dominion
  module Engine
    class Gardens < Victory
      
      def cost() 4 end
      def points(player=nil)
        player.nil? ? 0 : player.deck.size % 10
      end
      def to_s() 'Gardens' end
        
    end
  end
end