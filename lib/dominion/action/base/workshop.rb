module Dominion
  class Workshop < Action

    def cost() 3          end
    def to_s() 'Workshop' end
    
    def play(turn)
      card = turn.player.select_card turn.game.buyable(4)
      turn.gain(card) if card
    end

  end
end