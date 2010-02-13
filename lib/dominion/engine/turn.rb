module Dominion
  module Engine
    class Turn
      
      attr_accessor :game, :player, :number_actions, :number_buys, :actions, :in_play, :treasure
      
      def initialize(game, player)
        @game           = game
        @player         = player
        @number_actions = 1
        @number_buys    = 1
        @actions        = Pile.new
        @treasure       = 0
        @in_play        = []
      end
      
      def take
        puts "\n#{player.name}'s turn:"
        say_hand
        spend_actions
        play_treasure
        spend_buys
        clean_up
      end
      
      def say_hand
        puts "Your hand: #{player.hand}"
      end
      
      def spend_actions
        action = player.choose_action
        while(action)
          @number_actions = number_actions - 1
          execute action
        end
      end
      
      def execute(action)
        player.hand.delete action
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
      
      def play_treasure
        player.hand.each do |card|
          if card.is_a? Treasure
            @in_play << card
            player.hand.delete card
            @treasure = treasure + card.value
          end
        end
      end
      
      def spend_buys
        puts "You #{treasure} treasure and #{number_buys} buy"
        puts "You buy a Province"
        gain game.provinces.first
      end
      
      def clean_up
        player.discard_hand
        player.draw_hand
      end
      
      def other_players
        game.players.reject{|p| p == player}
      end
      
    end
  end
end