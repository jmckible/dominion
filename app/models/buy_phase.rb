class BuyPhase
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
      turn.cleanup
      game.move_on
    end
  end
  
  def play
    player.say "$#{turn.treasure} and #{turn.number_buys} buy"
    player.make_buy turn
  end
  
end