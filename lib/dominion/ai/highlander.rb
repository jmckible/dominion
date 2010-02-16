# This player is the next evolution of Big Money. It'll take one action at the
# start of the game. Whenever possible, it will play that action. You can see
# how Smithy or Chancellor can make this deck better than raw Big Money.

module Dominion
  module AI
    class Highlander < Dominion::Engine::Player
      
      attr_accessor :action, :wants
      
      # For wants, pass in an array of buyable things
      # i.e. - [Chancellor, Smithy, Market]
      # It will buy the first available of these once
      def initialize(wants=nil)
        if wants
          @wants = wants
        else
          # Just a default list. Hopefully one will be available
          @wants = [Chancellor, Smithy, Festival, Laboratory, Market, CouncilRoom]
        end
      end
    
      def select_buy(cards)
        if action # Single buy has been made
          big_money_buy cards
        else
          wants.each do |want|
            cards.each do |card|
              return card if card.is_a?(want)
            end
          end
          big_money_buy # Nothing available, default to big money
        end
      end
      
      def big_money_buy(cards)
        [Province, Gold, Silver, Copper].each do |want|
          card = cards.detect{|c| c.is_a? want}
          return card if card
        end
        return nil
      end
    
    end
  end
end