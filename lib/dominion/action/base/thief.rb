module Dominion
  ###########################################################################
  #                                A C T I O N                              #
  ###########################################################################
  class Thief < Action  
    def cost() 4       end
    def to_s() 'Thief' end
      
    def play(turn)
      turn.other_players.each{|p| turn.player.thief p}
    end
  end
  
  ###########################################################################
  #                                 P L A Y E R                             #
  ###########################################################################
  class Player
    def thief(player)
      return false if moat?
      revealed = player.reveal 2
      broadcast "#{player} revealed #{revealed.join ', '}"
      unless revealed.treasures.empty?
        card = revealed.treasures.first
        if card
          discard.unshift card
          broadcast "#{name} stole #{player}'s #{card}"
          revealed.delete card
        end
      end
      revealed.each{|c| player.discard.unshift c}
    end
  end
  
  ###########################################################################
  #                                 H U M A N                               #
  ###########################################################################
  class Human < Player
    def thief(player)
      return false if moat?
      revealed = player.reveal 2
      broadcast "#{player} revealed #{revealed.join ', '}"
      unless revealed.treasures.empty?
        card = select_card revealed.treasures, :message=>"Choose a treasure to trash"
        if card
          if get_boolean("Would you like to steal #{card}?")
            discard.unshift card
            broadcast "#{name} stole #{player}'s #{card}"
          else
            game.trash.unshift card
            broadcast "#{name} trashed #{player}'s #{card}"
          end
          revealed.delete card
        end
      end
      revealed.each{|c| player.discard.unshift c}
    end
  end
  
end