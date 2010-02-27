module Dominion
  class Gardens < Victory
    def cost() 4 end
    def points(player=nil)
      player.nil? ? 0 : player.all_cards.size % 10
    end
    def to_s() 'Gardens' end 
  end
end