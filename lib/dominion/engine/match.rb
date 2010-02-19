module Dominion
  module Engine
    class Match
      
      attr_accessor :players, :picks, :scoreboards
      
      def initialize(options={})
        @picks       = options[:picks] || []
        @players     = []
        @scoreboards = []
      end
      
      def play
        game = Game.new :picks=>picks
        players.each do |player| 
          player.reset
          game.seat player
        end
        scoreboard = game.play
        scoreboards << scoreboard
        scoreboard
      end
      
      def to_s
        ties = scoreboards.count{|s| s.tie}
        games = scoreboards.count.to_f
        string = "#{ties} ties - #{ties/games*100}%\n"
        players.each do |player|
          wins = scoreboards.count{|s|s.winner == player}
          string << "#{player} won #{wins} - #{wins/games*100}%\n"
        end
        string
      end
      
    end
  end
end