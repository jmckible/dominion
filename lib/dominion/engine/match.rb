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
        scoreboard = game.play
        scoreboards << scoreboard
        scoreboard
      end
      
      def to_s
        string = ''
        players.each do |player|
          string << "#{player} won #{scoreboards.count{|s|s.winner == player}}\n"
        end
        string
      end
      
    end
  end
end