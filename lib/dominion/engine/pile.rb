module Dominion
  module Engine
    class Pile
      attr_accessor :card_type, :cards
      
      def initialize
        self.cards = []
      end
      
      def fill(card_type, count)
        self.card_type = card_type
        1.upto(count){cards << card_type.new}
      end
      
      def size() cards.size end
      def empty?() cards.empty? end   
        
    end
  end
end