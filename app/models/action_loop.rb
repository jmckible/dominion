class ActionLoop
  include EM::Deferrable
  
  attr_accessor :turn, :game
  
  def self.spin(turn)
    action_loop = ActionLoop.new turn
    turn.await action_loop
    action_loop.callback do |index|
      integer = index.to_i
      card = turn.player.available_actions[integer]
      if card
        turn.number_actions = turn.number_actions - 1
        turn.execute action
        turn.await turn.player.action_loop(turn)
      else
        turn.deferred_block.succeed
      end
    end
    action_loop
  end
  
  def initialize(turn)
    @turn = turn
    @game = turn.game
  end
  
end