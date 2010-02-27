module Dominion
  ###########################################################################
  #                                A C T I O N                              #
  ###########################################################################
  class Bureaucrat < Action
    
    def cost() 4            end
    def to_s() 'Bureaucrat' end
      
    def play(turn)
      silver = turn.game.silvers.first
      if silver
        turn.player.deck.unshift silver
        turn.game.remove silver
      end
      
      turn.other_players.each do |player|
        if player.moat?
          turn.broadcast "#{player} revealed a Moat"
        else
          victory = player.bureaucrat_selection
          if victory
            player.hand.delete victory
            player.deck.unshift victory
            turn.broadcast "#{player} revealed a #{victory} and put it on top of their deck"
          else
            turn.broadcast "#{player} reveals #{player.hand.join ', '}"
          end
        end
        
      end
    end
  end
  
  ###########################################################################
  #                                 P L A Y E R                             #
  ###########################################################################
  class Player
    def bureaucrat_selection
      hand.victories.first 
    end
  end
  
  ###########################################################################
  #                                 H U M A N                               #
  ###########################################################################
  class Human < Player
    def bureaucrat_selection
      return nil if hand.victories.empty?
      select_card hand.victories, :message=>'Select a card to put on top of your deck', 
        :force=>true
    end
  end
  
end