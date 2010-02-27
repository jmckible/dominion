module Dominion
  class Scoreboard
  
    def self.calculate(game)
      Scoreboard.new(game).calculate
    end
  
    attr_accessor :game, :scores, :winner, :tie
    
    def initialize(game)
      @game = game
      @scores = []
    end
    
    def calculate
      game.players.each do |player|
        @scores << Score.calculate(player)
      end
      @scores = scores.sort
      if scores[0].points == scores[1].points &&
         scores[0].player.turns == scores[1].player.turns
        @tie = true
      else
        @tie = false
        @winner = scores.first.player
      end
      self
    end
    
    def to_s
      string = ''
      scores.each do |score|
        string << "#{score.player}'s Score: #{score.points} points, #{score.player.turns} turns\n"
      end
      if tie
        string << "Tie game\n"
      else
        string << "Winner: #{winner}\n"
      end
      string
    end
  
  end
end