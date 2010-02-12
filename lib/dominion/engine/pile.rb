module Dominion
  module Engine
    class Pile < Array
      
      def initialize(card_type=nil, number=nil)
        if card_type 
          1.upto(number || card_type.starting_count){self << card_type.new }
        end
      end
      
      def discard(number)
        1.upto(number){pop}
      end
      
    end
  end
end