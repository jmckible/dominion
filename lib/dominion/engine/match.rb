module Dominion
  module Engine
    class Match
      
      attr_accessor :players, :scoreboards
      
      def initialize
        @players = []
        @scoreboards = []
      end
      
      def play
        game = Game.new
        players.each do |player| 
          player.reset
          game.seat player
        end
        scoreboards << game.play
      end
      
      def to_s
        string = ''
        scoreboards.each_with_index do |scoreboard, i|
          string << "Game #{i+1}\n"
          scoreboard.scores.each do |score|
            string << "  #{score.player} - #{score.points} points\n"
          end
          string << "  Winner: #{scoreboard.winner}\n"
        end
        string << "\n"
        players.each do |player|
          string << "#{player} won #{scoreboards.count{|s|s.winner == player}}\n"
        end
        string
      end
      
    end
  end
end