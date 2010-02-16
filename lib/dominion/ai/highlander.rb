# This player is the next evolution of Big Money. It'll take one action at the
# start of the game. Whenever possible, it will play that action. You can see
# how Smithy or Chancellor can make this deck better than raw Big Money.

module Dominion
  module AI
    class Highlander < Dominion::Engine::Player
      
      attr_accessor :action, :wants
      
      def set_wishlist(wants)
        @wants = wants
      end
    
      def select_buy(cards)
        if action # Single buy has been made
          big_money_buy cards
        else
          wants.each do |want|
            cards.each do |card|
              if card.is_a?(want)
                @action = card
                return card
              end
            end
          end
          big_money_buy cards # Nothing available, default to big money
        end
      end
      
      def big_money_buy(cards)
        [Province, Gold, Silver, Copper].each do |want|
          card = cards.detect{|c| c.is_a? want}
          return card if card
        end
        return nil
      end
      
      def choose_action
        available_actions.first
      end
      
      # Might want to change this if you're about to buy a Province
      def use_chancellor?(turn)
        true
      end
    
    end
  end
end