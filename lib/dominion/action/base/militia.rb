module Dominion
  class Militia < Action
    
    def cost() 4         end
    def to_s() 'Militia' end
      
    def play(turn)
      turn.add_treasure 2
      turn.other_players.each do |player|
        discards = player.militia_discard
        if discards
          if discards.empty?
            turn.broadcast "#{player} didn't need to discard"
          else
            discards.each{|c| player.discard_card c}
            turn.broadcast "#{player} discarded #{discards.join ', '}"
          end
        else
          turn.broadcast "#{player} revealed at Moat"
        end
      end
    end
      
  end
end