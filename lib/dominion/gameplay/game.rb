module Dominion
  class Game
    attr_accessor :players
  
    def initialize(num_players)
      self.players = []
      1.upto(num_players){self.players << Player.new}
    end
  
    def play
    
    end
  
  end
end