module Dominion
  class Match
    
    attr_accessor :players, :use, :scoreboards, :server
    
    def initialize(options={})
      @use         = options[:use] || []
      @server      = options[:server]
      @players     = []
      @scoreboards = []
    end
    
    def play
      game = Game.new :use=>use, :server=>server
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