module Dominion
  module AI
    class BigMoney < Engine::Player
      
      def select_buy(cards)
        province = cards.select{|c| c.is_a? Province}.first
        return province if province
        
        gold = cards.select{|c| c.is_a? Gold}.first
        return gold if gold
        
        silver = cards.select{|c| c.is_a? Silver}.first
        return silver if silver
        
        copper = cards.select{|c| c.is_a? Copper}.first
        return copper if copper
        
        return nil
      end
      
    end
  end
end