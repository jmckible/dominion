module Dominion
  module Engine
    class Player
      attr_accessor :name, :deck, :discard, :hand
    
      def initialize(name)
        @deck    = Deck.new
        @discard = Pile.new
        @name    = name
        @hand    = Pile.new
      end
      
      def gain(card)
        discard.unshift card
      end
      
      def draw_hand
        draw_cards 5
      end
      
      def draw_card(number=1)
        1.upto(number) do
          unless deck.empty? && discard.empty?
            reshuffle if deck.empty?
            hand << deck.shift
          end
        end
      end
      alias :draw_cards :draw_card
      
      def reshuffle
        while(!discard.empty?)
          @deck << discard.shift
        end
        @deck = deck.shuffle
      end
      
      def choose_action
        return false if available_actions.empty?
        puts '0. Done'
        available_actions.each_with_index do |card, i|
          puts "#{i+1}. #{card}\n"
        end
        puts 'Choose an action:'
        choice = gets.chomp.to_i
        return false if choice == 0
        available_actions[choice - 1]
      end
      
      def available_actions
        hand.select{|card|card.is_a?(Action) }
      end
      
      def discard_deck
        while(!deck.empty?)
          @discard.unshift deck.shift
        end
      end
      
    end
  end
end