require 'dominion'

Spec::Runner.configure do |config|  
  def running(&block)
    lambda(&block)
  end
end


class GameFactory
  
  def self.create(players)
    game = Game.new
    1.upto(players){|i|game.seat Player.new("Player #{i}")}
    game.deal
    game
  end
  
  def self.build(players=4)
    game = GameFactory.create players
    player = game.players.next 
    turn = Turn.new game, player
    return game, player, turn
  end
  
end