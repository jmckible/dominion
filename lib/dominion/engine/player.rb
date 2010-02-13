module Dominion
  module Engine
    class Player
      attr_accessor :name, :deck, :discard, :hand, :socket
    
      #########################################################################
      #                             I N I T I A L I Z E                       #
      #########################################################################
      def initialize(name, socket)
        @deck    = Deck.new
        @discard = Pile.new
        @name    = name
        @hand    = Pile.new
        @socket  = socket
      end
      
      #########################################################################
      #                                   I / O                               #
      #########################################################################
      def get_boolean(prompt)
        Input.get_integer socket, prompt
      end
      
      def get_integer(prompt, lower, upper)
        Input.get_integer socket, prompt, lower, upper
      end
      
      def puts(string)
        socket.puts string
      end
      
      def gets(string)
        socket.gets string
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
      #                               O U T P U T                             #
      #########################################################################
      def say_score
        score = 0
        deck.each do |card|
          if card.is_a? Victory
            points = card.points self
            socket.puts "#{card} = #{points}"
            score = score + points
          end
        end
        socket.puts "#{name}'s Final score: #{score}\n\n"
      end
      
      def say_available_actions
        socket.puts '0. Done'
        available_actions.each_with_index do |card, i|
          socket.puts "#{i+1}. #{card}\n"
        end
      end
      
      def to_s() name end
      
    end
  end
end