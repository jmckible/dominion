module Dominion
  module Engine
    class Pile < Array
      
      def initialize(card_type=nil, number=nil)
        1.upto(number){self << card_type.new } if card_type && number
      end
      
      def discard(number)
        1.upto(number){pop}
      end
      
    end
  end
end