module Dominion
  class CouncilRoom < Action
    
    def cost() 5              end
    def to_s() 'Council Room' end
      
    def play(turn)
      turn.draw 4
      turn.add_buy
      turn.other_players.each do |player|
        player.draw
        turn.broadcast "#{player} drew a card"
      end
    end
      
  end
end