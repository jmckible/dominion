module Dominion
  module Engine
    class Pile < Array
      attr_accessor :card_type
      
      def fill(card_type, count)
        self.card_type = card_type
        1.upto(count){self << card_type.new}
      end
      
      def cards() self end

    end
  end
end