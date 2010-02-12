module Dominion
  module Engine
    class Pile < Array
      
      def fill(card_type, count)
        1.upto(count){self << card_type.new}
      end
      
    end
  end
end