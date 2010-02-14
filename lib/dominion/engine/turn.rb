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
        broadcast "\n#{player}'s Round #{game.players.round} turn:" if game.server
        say_hand
        say_actions
        spend_actions
        play_treasure
        spend_buys
        player.discard_hand
        while(!in_play.empty?)
          player.discard << in_play.shift 
        end
        player.draw_hand
      end
      
      #########################################################################
      #                            M O V E    C A R D S                       #
      #########################################################################
      def draw(number=1)
        drawn = player.draw number
        player.say "Drawing #{number}: #{drawn}"
        return drawn
      end
      
      def gain(card)
        game.remove card
        player.gain card
      end
      
      # Trash in play from Feast or from hand for Chapel
      def trash(card)
        @in_play.delete card
        player.hand.delete card
        game.trash.unshift(card) unless game.trash.include?(card)
      end
      
      # Cellar
      def discard(card)
        player.hand.delete card
        player.discard.unshift card
      end
      
      #########################################################################
      #                               A C T I O N S                           #
      #########################################################################
      def spend_actions
        action = player.choose_action
        while(action)
          broadcast "#{player} played a #{action}"
          @number_actions = number_actions - 1
          execute action
          return if @number_actions < 1
          action = player.choose_action
        end
      end
      
      def execute(action)
        @in_play << action unless in_play.include?(action)
        player.hand.delete action
        action.play self
        say_hand
        say_actions
      end
      
      def add_action(number=1)
        @number_actions = number_actions + number
      end
      alias :add_actions :add_action
      
      #########################################################################
      #                             T R E A S U R E                           #
      #########################################################################
      def play_treasure
        player.hand.select{|card| card.is_a?(Treasure)}.each do |card|
          @in_play << card unless in_play.include?(card)
          player.hand.delete card
          @treasure = treasure + card.value
        end
      end
      
      def add_treasure(number)
        @treasure = treasure + number
      end
      
      def spend_treasure(number)
        @treasure = treasure - number
      end
      
      #########################################################################
      #                                  B U Y                                #
      #########################################################################
      def spend_buys
        while number_buys > 0
          available_cards = game.buyable treasure          
          if game.server
            player.say "$#{treasure} and #{number_buys} buy"
            player.say '0. Done'
            available_cards.each_with_index do |card, i|
              player.say "#{i+1}. #{card} ($#{card.cost}) - #{game.number_available card.class} left"
            end
          end
          choice = player.get_integer 'Choose a card to buy', 0, available_cards.size
          return if choice == 0
          buy available_cards[choice - 1]
        end
      end
      
      def buy(card)
        spend_buy
        spend_treasure card.cost
        gain card
        broadcast "#{player} bought a #{card}"
      end
      
      def add_buy(number=1)
        @number_buys = number_buys + number
      end
      alias :add_buys :add_buy
      
      def spend_buy
        @number_buys = number_buys - 1
      end
      
      #########################################################################
      #                                  I / O                                #
      #########################################################################
      def broadcast(message)
        game.broadcast message
      end
      
      def say_hand
        player.say "Hand: #{player.hand.sort}"
      end
      
      def say_card_list(list)
        return unless game.server
        player.say '0. Done'
        list.each_with_index do |card, i|
          player.say "#{i+1}. #{card}"
        end
      end
      
      def say_actions
        broadcast "#{number_actions} actions remaining"
      end
      
      def select_card(cards)
        say_card_list cards
        choice = player.ask('Choose a card').chomp.to_i
        while choice < 0 || choice > cards.size
          say_card_list cards
          choice = player.ask('Choose a valid card').chomp.to_i
        end
        return nil if choice == 0
        cards[choice - 1]
      end
      
    end
  end
end