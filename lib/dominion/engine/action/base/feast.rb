module Dominion
  module Engine
    class Feast < Action
      
      def cost() 4 end
      def to_s() 'Feast' end
      
      def play(turn)
        card = turn.select_card turn.game.buyable 5
        turn.gain(card) if card
        turn.trash self
      end
      
    end
  end
end