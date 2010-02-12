module Dominion
  module Engine
    class Turn
      
      attr_accessor :game, :player, :number_actions, :number_buys, :actions, :buys, :in_play, :treasure
      
      def initialize(game, player)
        @game           = game
        @player         = player
        @number_actions = 1
        @number_buys    = 1
        @actions        = Pile.new
        @buys           = Pile.new
        @treasure       = 0
        @in_play        = []
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
        @in_play << action
        action.play self
      end
      
      def add_action(number=1)
        @number_actions = number_actions + number
      end
      alias :add_actions :add_action
      
      def add_buy(number=1)
        @number_buys = number_buys + number
      end
      alias :add_buys :add_action
      
      def add_treasure(number)
        @treasure = treasure + number
      end
      
      def draw_card(number=1)
        player.draw_card number
      end
      alias :draw_cards :draw_card
      
      def gain(card)
        game.remove card
        player.gain card
      end
      
      # Trash in play card (Feast)
      def trash(card)
        @in_play.delete card
        game.trash.unshift card
      end
      
      def spend_buys
      end
      
      def clean_up
        player.draw_hand
      end
      
      def other_players
        game.players.reject{|p| p == player}
      end
      
    end
  end
end