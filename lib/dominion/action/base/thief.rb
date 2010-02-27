module Dominion
  class Thief < Action
    
    def cost() 4       end
    def to_s() 'Thief' end
      
    def play(turn)
      turn.other_players.each{|p| turn.player.thief p}
    end
      
  end
end