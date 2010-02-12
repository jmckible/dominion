module Dominion
  module Engine
    class Turn
      
      attr_accessor :player, :number_actions, :number_buys, :actions, :buys
      
      def initialize(player)
        self.player         = player
        self.number_actions = 1
        self.number_buys    = 1
        self.actions        = Pile.new
        self.buys           = Pile.new
      end
      
    end
  end
end