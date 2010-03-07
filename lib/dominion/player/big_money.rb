module Dominion
  class BigMoney < Player
  
    def choose_action
      nil
    end
  
    def select_buy(cards)
      [Province, Gold, Silver, Copper].each do |want|
        card = cards.detect{|c| c.is_a? want}
        return card if card
      end
      return nil
    end
  
  end
end