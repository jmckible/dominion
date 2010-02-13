module Dominion
  module Engine
    class Turn
      
      attr_accessor :actions, :game, :in_play, :player
      attr_accessor :number_actions, :number_buys, :treasure
      
      def other_players
        game.players.reject{|p| p == player}
      end
      
      #########################################################################
      #                           I N I T I A L I Z E                         #
      #########################################################################
      def initialize(game, player)
        @game           = game
        @player         = player
        @number_actions = 1
        @number_buys    = 1
        @actions        = Pile.new
        @treasure       = 0
        @in_play        = []
      end
      
      #########################################################################
      #                                  T A K E                              #
      #########################################################################
      def take
        puts "\n#{player.name}'s turn:"
        say_hand
        spend_actions
        play_treasure
        spend_buys
        player.discard_hand
        player.draw_hand
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
      
      #########################################################################
      #                             T R E A S U R E                           #
      #########################################################################
      def play_treasure
        player.hand.select{|card| card.is_a?(Treasure)}.each do |card|
          @treasure = treasure + card.value
          @in_play << card
          player.hand.delete card
        end
      end
      
      #########################################################################
      #                                  B U Y                                #
      #########################################################################
      def spend_buys
        puts "You #{treasure} treasure and #{number_buys} buy"
        while number_buys > 0
          available_cards = game.buyable treasure
          puts 'Choose a card to buy'
          puts '0. Done'
          available_cards.each_with_index do |card, i|
            puts "#{i+1}. #{card}"
          end
          choice = gets.chomp.to_i
          while choice < 0 || choice > available_cards.size
            puts 'Choose a valid card'
            show_card_list
            choice = gets.chomp.to_i
          end
          return if choice == 0
          card = available_cards[choice - 1]
          gain(card) if card
          @number_buys = number_buys - 1
          @tresaure = treasure - card.cost
        end
      end
      
      #########################################################################
      #                                O U T P U T                            #
      #########################################################################
      def say_hand
        puts "Your hand: #{player.hand.sort}"
      end
      
    end
  end
end