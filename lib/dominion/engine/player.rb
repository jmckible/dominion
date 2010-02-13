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
        list_available_actions
        choice = gets.chomp.to_i
        unless choice >= 0 && choice < available_actions.count
          puts 'Please choose a valid action'
          list_available_actions
        end
        return false if choice == 0
        available_actions[choice - 1]
      end
      
      def available_actions
        hand.select{|card|card.is_a?(Action) }
      end
      
      def list_available_actions
        puts '0. Done'
        available_actions.each_with_index do |card, i|
          puts "#{i+1}. #{card}\n"
        end
        puts 'Choose an action:'
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
      
      def combine_cards
        discard_hand
        reshuffle
      end
      
      def say_score
        score = 0
        deck.each do |card|
          if card.is_a? Victory
            points = card.points self
            puts "#{card} = #{points}"
            score = score + points
          end
        end
        puts "#{name}'s Final score: #{score}\n\n"
      end
      
    end
  end
end