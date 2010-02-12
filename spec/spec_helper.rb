require 'dominion'

Spec::Runner.configure do |config|  
  def running(&block)
    lambda(&block)
  end
end


class GameFactory
  def self.build(players=4)
    game = Game.new
    1.upto(players){|i|game.seat Player.new("Player #{i}")}
    game.setup
    game
  end
end