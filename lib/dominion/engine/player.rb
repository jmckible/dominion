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
      
      def draw_hand(size=5)
        1.upto(size) do
          unless deck.empty? && discard.empty?
            reshuffle if deck.empty?
            hand << deck.shift
          end
        end
      end
      
      def reshuffle
        while(!discard.empty?)
          deck << discard.shift
        end
        deck.shuffle
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
      
    end
  end
end