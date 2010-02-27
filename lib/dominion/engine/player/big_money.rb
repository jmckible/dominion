module Dominion
  module Engine
    class BigMoney < Player
    
      def select_buy(cards)
        [Province, Gold, Silver, Copper].each do |want|
          card = cards.detect{|c| c.is_a? want}
          return card if card
        end
        return nil
      end
    
    end
  end
end