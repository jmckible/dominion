module Dominion
  module Engine
    class Warehouse < Action
      
      def cost() 5           end
      def to_s() 'Warehouse' end
        
      def play(turn)
        turn.player.draw 3
        turn.add_action
        discards = turn.player.warehouse_discard
        discards.each{|card| turn.player.discard_card card}
        turn.broadcast "#{turn.player} discarded #{discards}"
      end
        
    end
  end
end