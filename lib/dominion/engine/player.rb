module Dominion
  module Engine
    class Player
      attr_accessor :name, :deck, :discard, :hand
    
      def initialize(name)
        self.deck    = Deck.new
        self.discard = Pile.new
        self.name    = name
        self.hand    = Pile.new
      end
      
      def gain(card)
        discard.unshift card
      end
      
      def draw_hand(size=5)
        1.upto(size) do
          unless deck.empty? && discard.empty?
            reshuffle if deck.empty?
            self.hand << deck.shift
          end
        end
      end
      
      def reshuffle
        while(!discard.empty?)
          deck << discard.shift
        end
        deck.shuffle
      end
      
    end
  end
end