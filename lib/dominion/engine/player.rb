module Dominion
  module Engine
    class Player
      attr_accessor :name, :deck, :discard, :hand, :socket, :game, :turns
    
      #########################################################################
      #                             I N I T I A L I Z E                       #
      #########################################################################
      def initialize(name, socket=nil)
        @name   = name        
        @socket = socket
        reset
      end
      
      # Reset for another game
      def reset
        @deck    = Deck.new
        @discard = Pile.new
        @name    = name
        @hand    = Pile.new
        @turns   = 0
      end
      
      #########################################################################
      #                                  G A I N                              #
      #########################################################################
      def gain(card)
        discard.unshift card
      end
      
      #########################################################################
      #                                  D R A W                              #
      #########################################################################
      def draw(number=1)
        drawn = Pile.new
        1.upto(number) do |i|
          if can_draw?
            reshuffle if deck.empty?
            card = deck.shift
            @hand << card
            drawn << card
          end
        end
        drawn
      end
      def draw_hand() draw 5 end
      def can_draw?() deck.size + discard.size > 0 end
        
      def reveal(number=1)
        revealed = Pile.new
        1.upto(number) do |i|
          if can_draw?
            reshuffle if deck.empty?
            revealed << deck.shift
          end
        end
        revealed
      end
      
      #########################################################################
      #                                S H U F F L E                          #
      #########################################################################
      def reshuffle
        while(!discard.empty?)
          @deck << discard.shift
        end
        @deck = deck.shuffle
      end
      
      # Prepare deck to count points
      def combine_cards
        discard_hand
        reshuffle
      end
      
      #########################################################################
      #                               D I S C A R D                           #
      #########################################################################
      def discard_card(card)
        hand.delete card
        discard.unshift card
      end
      
      def discard_deck
        while(!deck.empty?)
          @discard.unshift deck.shift
        end
      end
      
      def discard_hand
        while(!hand.empty?)
          @discard.unshift hand.shift
        end
      end
      
      #########################################################################
      #                               A C T I O N S                           #
      #########################################################################
      def choose_action
        return false if available_actions.empty?
        say_available_actions
        choice = get_integer 'Choose an Action', 0, available_actions.size
        return false if choice == 0
        available_actions[choice - 1]
      end
      
      def available_actions
        hand.select{|card|card.is_a?(Action) }
      end
      
      #########################################################################
      #                                   B U Y                               #
      #########################################################################
      def select_buy(cards)
        say '0. Done'
        cards.each_with_index do |card, i|
          say "#{i+1}. #{card} ($#{card.cost}) - #{game.number_available card.class} left"
        end
        choice = get_integer 'Choose a card to buy', 0, cards.size
        return nil if choice == 0
        cards[choice - 1]
      end
      
      #########################################################################
      #                          C A R D     S P E C I F I C                  #
      #########################################################################
      def bureaucrat_selection
        return nil if hand.victories.empty?
        return hand.victories.first unless socket # AI player
        select_card hand.victories, :message=>'Select a card to put on top of your deck', 
          :force=>true
      end
      
      def use_chancellor?(turn)
        return true unless socket # AI player
        get_boolean 'Would you like discard your deck?'
      end
      
      def militia_discard
        if socket
          discards = []
          while hand.size > 3
            discards << select_card(player.hand, 
              :message=>"Choose a card to discard (from #{turn.player}'s Militia)",
              :force=>true)
          end
        else # AI Player
          discards = hand[3..-1]
        end
        
        if discards.empty?
          broadcast "#{name} didn't need to discard"
        else
          discards.each{|c| discard_card c}
          broadcast "#{name} discarded #{discards.join ', '}"
        end
      end
      
      def spy_on(player)
        card = player.reveal.first
        if card
          broadcast "#{player} reveals a #{card}"
          
          if socket
            return_to_deck = get_boolean "Return #{card} to top #{player}'s deck?"
          else # AI Player
            return_to_deck = card.is_a? Victory
          end
          
          if return_to_deck
            player.deck.unshift card
            broadcast "#{name} returned #{player}'s #{card} to the top of their deck"
          else
            player.discard.unshift card
            broadcast "#{name} made #{player} discard #{card}"
          end
        end
      end
      
      def thief(player)
        revealed = player.reveal 2
        broadcast "#{player} revealed #{revealed.join ', '}"
        unless revealed.treasures.empty?
          card = select_card revealed.treasures, :message=>"Choose a treasure to trash"
          if card
            if get_boolean("Would you like to steal #{card}?")
              discard.unshift card
              broadcast "#{name} stole #{player}'s #{card}"
            else
              game.trash.unshift card
              broadcast "#{name} trashed #{player}'s #{card}"
            end
            revealed.delete card
          end
        end
        revealed.each{|c| player.discard.unshift c}
      end
      
      #########################################################################
      #                                   I / O                               #
      #########################################################################
      def get_boolean(prompt)
        Input.get_boolean socket, prompt
      end
      
      def get_integer(prompt, lower, upper)
        Input.get_integer socket, prompt, lower, upper
      end
      
      def say(string)
        return unless game.server && socket
        socket.puts string
      end
      
      def ask(string)
        return unless game.server && socket
        say string
        socket.gets
      end
      
      def broadcast(string)
        game.broadcast string
      end
      
      def say_card_list(cards, force=false)
        say '0. Done' unless force
        cards.each_with_index do |card, i|
          say "#{i+1}. #{card}"
        end
      end
      
      def say_available_actions
        return unless game.server
        say '0. Done'
        available_actions.each_with_index do |card, i|
          say "#{i+1}. #{card}\n"
        end
      end
      
      def select_card(cards, options={})
        message = options[:message] || 'Choose a card'
        force   = options[:force]   || false
        
        say_card_list cards, force
        choice = ask(message).chomp.to_i
        while (force ? (choice < 1) : (choice < 0)) || choice > cards.size
          say_card_list cards, force
          choice = ask('Choose a valid card').chomp.to_i
        end
        return nil if choice == 0 && !force
        cards[choice - 1]
      end
      
      def to_s() name end
      
    end
  end
end