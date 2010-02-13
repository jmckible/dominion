module Dominion
  module Engine
    class CouncilRoom < Action
      def cost() 5 end
      def name() 'Council Room' end
        
      def play(turn)
        turn.draw 4
        turn.add_buy
        turn.other_players.each{|p|p.draw}
      end
        
    end
  end
end