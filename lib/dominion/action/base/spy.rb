module Dominion
  ###########################################################################
  #                                A C T I O N                              #
  ###########################################################################
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
  
  ###########################################################################
  #                                 P L A Y E R                             #
  ###########################################################################
  class Player
    # Return false to halt attack
    # Else return spied card
    def spy_on(player)
      return false if moat?
      player.reveal.first
    end

    # True to discard
    # False to put it back on top of deck
    def discard_from_spy?(card, player)
      !(card.is_a?(Victory) || card.is_a?(Curse))
    end
  end
  
  ###########################################################################
  #                                 H U M A N                               #
  ###########################################################################
  class TerminalPlayer < Player
    def discard_from_spy?(card, player)
      !get_boolean("Would you like to make #{player} discard #{card}? (Otherwise it goes back on top of their deck)")
    end
  end
  
end