module Dominion
  module Engine
    class Player
      attr_accessor :deck, :discard, :name
    
      def initialize(name)
        self.deck    = Deck.new
        self.discard = Pile.new
        self.name    = name
      end
      
      def gain(card)
        self.discard << card
      end
      
    end
  end
end