module Dominion
  module Engine
    class Turn
      
      attr_accessor :player, :number_actions, :number_buys, :actions, :buys, :in_play
      
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
        action = player.choose_action
        while(action)
          @number_actions = number_actions - 1
          execute action
        end
      end
      
      def execute(action)
        action.play self
      end
      
      def add_action
        @number_actions = number_actions + 1
      end
      
      def draw_card
        player.draw_card
      end
      
      def spend_buys
      end
      
      def clean_up
        player.draw_hand
      end
      
    end
  end
end