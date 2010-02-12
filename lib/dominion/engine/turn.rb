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
      
      def take
        spend_actions
        spend_buys
        clean_up
      end
      
      def spend_actions
      end
      
      def spend_buys
      end
      
      def clean_up
        player.draw_hand
      end
      
    end
  end
end