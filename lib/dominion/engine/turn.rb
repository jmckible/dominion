module Dominion
  module Engine
    class Turn
      
      attr_accessor :player, :number_actions, :number_buys, :actions, :buys, :in_play, :treasure
      
      def initialize(player)
        @player         = player
        @number_actions = 1
        @number_buys    = 1
        @actions        = Pile.new
        @buys           = Pile.new
        @treasure       = 0
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
      
      def add_buy
        @number_buys = number_buys + 1
      end
      
      def add_treasure(number)
        @treasure = treasure + number
      end
      
      def draw_card(number=1)
        player.draw_card number
      end
      alias :draw_cards :draw_card
      
      def spend_buys
      end
      
      def clean_up
        player.draw_hand
      end
      
    end
  end
end