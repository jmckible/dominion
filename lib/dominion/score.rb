module Dominion
  class Score
    
    def self.calculate(player)
      Score.new(player).calculate
    end
    
    attr_accessor :player, :points
    
    def initialize(player)
      @player = player
      @points = 0
    end
    
    def <=>(other)
      if other.points != points
        other.points <=> points
      else
        player.turns <=> other.player.turns
      end
    end
    
    def calculate
      player.all_cards.each do |card|
        @points += card.points(player) if card.is_a?(Victory) || card.is_a?(Curse)
      end
      self
    end
    
  end
end