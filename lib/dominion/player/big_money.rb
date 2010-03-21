module Dominion
  class BigMoney < Player
  
    def choose_action
      nil
    end
  
    def select_buy(cards)
      [Province, Gold, Duchy, Silver].each do |want|
        card ||= cards.detect{|c| c.is_a? want}
      end      
      turn.deferred_block.suceeded card
    end
  
  end
end