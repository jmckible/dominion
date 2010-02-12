module Dominion
  module Engine
    class Deck
      attr_accessor :cards
      
      def initialize
        self.cards = []
      end
      
      def shuffle
        cards.sort_by{rand}
      end
      
    end
  end
end