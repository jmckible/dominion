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
        string = ''
        players.each do |player|
          string << "#{player} won #{scoreboards.count{|s|s.winner == player}}\n"
        end
        string
      end
      
    end
  end
end