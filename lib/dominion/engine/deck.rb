module Dominion
  module Engine
    class Deck < Array
      
      def shuffle
        sort_by{rand}
      end
      
    end
  end
end