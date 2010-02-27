module Dominion
  class Spy < Action
    
    def cost() 4     end
    def to_s() 'Spy' end
      
    def play(turn)
      turn.draw
      turn.add_action
      
      turn.other_players.each do |player|
        card = turn.player.spy_on player
        turn.broadcast "#{player} revealed a #{card}"
        if turn.player.discard_from_spy?(card, player)
          player.deck.unshift card
          turn.broadcast "#{turn.player} returned #{player}'s #{card} to the top of their deck"
        else
          player.discard.unshift card
          turn.broadcast "#{turn.player} made #{player} discard #{card}"
        end
      end

      card = turn.player.spy_on turn.player
      if turn.player.discard_from_spy?(card, turn.player)
        turn.player.deck.unshift card
        turn.player.say "You returned #{turn.player}'s #{card} to the top of their deck"
      else
        turn.player.discard.unshift card
        turn.broadcast "You discarded #{card}"
      end
    end
      
  end
end