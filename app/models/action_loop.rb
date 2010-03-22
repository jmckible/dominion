class ActionLoop
  include EM::Deferrable
  
  attr_accessor :turn, :game
  
  def self.spin(turn, &block)
    turn.game.say_stack "Starting ActionLoop.spin"
    turn.say_hand
    turn.say_actions
    turn.player.say_available_actions
    
    action_loop = ActionLoop.new turn
    turn.game.await action_loop 
    
    turn.game.await IndexDeferrable.new do |index|
      turn.game.say_stack "ActionLoop IndexDeferrable"
      integer = index.to_i
      card = turn.player.available_actions[integer]
      
      # Allow a single action
      if card
        turn.number_actions = turn.number_actions - 1
        turn.execute action
        turn.await turn.player.action_loop(turn)
      end
      
      turn.game.move_on
      
    end
    action_loop
  end
  
  def initialize(turn)
    @turn = turn
    @game = turn.game
  end
  
  def to_s() "Player #{turn.player}'s Action Loop" end
  
end