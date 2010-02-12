module Dominion
  module Engine
    class Turn
      
      attr_accessor :player, :actions, :buys, :cards
      
      def initialize
        self.actions = 1
        self.buys    = 1
        self.cards   = []
      end
      
    end
  end
end