module Dominion
  module Engine
    class Game
      def self.max_players
        4 # For base set
      end
      
      attr_accessor :players
    
      def initialize
        self.players = []
      end
  
      def seat(player)
        raise GameFull if full?
        self.players << player
        player.seat = players.size
      end
      
      def full?
        players.size >= Game.max_players
      end
      
    end
  end
end