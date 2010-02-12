module Dominion
  module Engine
    class Player
      attr_accessor :name, :deck, :discard, :hand
    
      def initialize(name)
        @deck    = Deck.new
        @discard = Pile.new
        @name    = name
        @hand    = Pile.new
      end
      
      def gain(card)
        discard.unshift card
      end
      
      def draw_hand(size=5)
        1.upto(size) do
          unless deck.empty? && discard.empty?
            reshuffle if deck.empty?
            hand << deck.shift
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