module Dominion
  module Engine
    class Scoreboard
    
      def self.calculate(game)
        Scoreboard.new(game).calculate
      end
    
      attr_accessor :game, :scores, :winner
      
      def initialize(game)
        @game = game
        @scores = []
      end
      
      def calculate
        game.players.each do |player|
          @scores << Score.calculate(player)
        end
        @winner = @scores.sort.first
        self
      end
      
      def to_s
        string = ''
        scores.each do |score|
          string << "#{score.player}'s Score: #{score.points}\n"
        end
        string
      end
    
    end
  end
end