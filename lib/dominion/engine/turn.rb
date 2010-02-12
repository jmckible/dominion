module Dominion
  module Engine
    class Turn
      
      attr_accessor :player, :number_actions, :number_buys, :actions, :buys
      
      def initialize(player)
        @player         = player
        @number_actions = 1
        @number_buys    = 1
        @actions        = Pile.new
        @buys           = Pile.new
      end
      
      def take
        spend_actions
        spend_buys
        clean_up
      end
      
      def spend_actions
        while(player.choose_action)
          action.play
        end
      end
      
      def spend_buys
      end
      
      def clean_up
        player.draw_hand
      end
      
    end
  end
end