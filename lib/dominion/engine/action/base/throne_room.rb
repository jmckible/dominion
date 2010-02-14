module Dominion
  module Engine
    class ThroneRoom < Action
            
      def cost() 4             end
      def to_s() 'Throne Room' end
      
      def play(turn)
        card = turn.select_card turn.player.hand.select{|c| c.is_a? Action}
        if card
          turn.broadcast "#{turn.player} selected #{card} to Throne Room"
          turn.execute card
          turn.execute card
        end
      end
      
    end
  end
end