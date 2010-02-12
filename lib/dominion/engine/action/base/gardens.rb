module Dominion
  module Engine
    class Gardens < Action
      include Base
      
      def self.starting_count() 12 end
      
      def cost() 4 end
        
    end
  end
end