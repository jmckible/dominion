module Dominion
  class BigMoney < Player
  
    def make_buy(turn)
      buyable = turn.game.buyable turn.treasure
      card = nil
      [Province, Gold, Duchy, Silver].each do |want|
        card ||= buyable.detect{|c| c.is_a? want}
      end  
          
      turn.buy card if card
      
      if turn.number_buys == 0 || card.nil?
        game.move_on # End buy phase
      else
        turn.buy_phase.play
      end
      
    end
  
  end
end