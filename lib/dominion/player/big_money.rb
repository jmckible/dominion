module Dominion
  class BigMoney < Player
  
    def choose_action
      nil
    end
  
    def select_buy(cards)
      card = nil
      [Province, Gold, Duchy, Silver].each do |want|
        card ||= cards.detect{|c| c.is_a? want}
      end      
      game.deferred_block.succeed card
    end
  
  end
end