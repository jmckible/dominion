module Dominion
  module Engine
    class Deck
      attr_accessor :cards
      
      def initialize
        self.cards = []
      end
      
      def setup
        1.upto(7){ self.cards << Copper.new}
        1.upto(3){ self.cards << Estate.new}
        shuffle
      end
      
      def shuffle
        cards.sort_by{rand}
      end
      
    end
  end
end