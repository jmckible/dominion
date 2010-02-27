module Dominion
  module Engine
    class Player
      include Base
      include Seaside
      
      attr_accessor :name, :deck, :discard, :hand, :game, :turns
    
      #########################################################################
      #                             I N I T I A L I Z E                       #
      #########################################################################
      def initialize(name)
        @name = name        
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
      
      def all_cards
        [deck, discard, hand].flatten
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
        raise "choose_action needs to be implemented"
      end
      
      def available_actions
        hand.select{|card|card.is_a?(Action) }
      end
      
      #########################################################################
      #                                   B U Y                               #
      #########################################################################
      def select_buy(cards)
        raise "select_buy needs to be implemented"
      end
      
      #########################################################################
      #                                   I / O                               #
      #########################################################################
      def say(string)
      end
      
      def ask(string)
      end
      
      def broadcast(string)
      end
      
      def say_card_list(cards, force=false)
      end
      
      def say_available_actions
      end
      
      def select_card(cards, options={})
      end
      
      def to_s
        name 
      end
      
    end
  end
end