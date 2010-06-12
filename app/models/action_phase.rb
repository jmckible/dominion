class ActionPhase
  include EM::Deferrable
  
  attr_accessor :turn, :player, :game
  
  def initialize(turn)
    @turn   = turn
    @player = turn.player
    @game   = turn.game
    add_callback
  end
  
  def add_callback
    callback do
      game.await turn.buy_phase
      turn.buy_phase.play
    end
  end
  
  def play
    if turn.number_actions == 0 || player.available_actions.empty?
      turn.play_treasure
      game.move_on
    else
      player.say "#{turn.number_actions} actions remaining"
      player.play_action turn
    end
  end
  
end