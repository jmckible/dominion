module Dominion
  module Engine
    class Player
      attr_accessor :deck, :name, :seat
    
      def initialize(name)
        self.deck = Deck.new
        self.name = name
      end
    end
  end
end