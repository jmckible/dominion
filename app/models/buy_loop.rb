class BuyLoop
  include EM::Deferrable
  
  attr_accessor :turn, :game
  
  def self.spin(turn)
    turn.play_treausre
    player.say "$#{treasure} and #{number_buys} buy"
    
    action_loop = BuyLoop.new turn
    turn.await buy_loop
    buy_loop.callback do |index|
      
      # Allow a single buy
      integer = index.to_i
      card = game.buyable(treasure)[integer]
      buy card if card
      turn.deferred_block.succeed
    end
    action_loop
  end
  
  def initialize(turn)
    @turn = turn
    @game = turn.game
  end
  
  def to_s() "Player #{turn.player}'s Buy Loop" end
  
end