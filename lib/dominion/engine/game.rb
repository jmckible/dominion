module Dominion
  module Engine
    class Game
      def self.max_players
        4 # For base set
      end
      
      attr_accessor :kingdoms, :players
      attr_accessor :coppers, :silvers, :golds 
      attr_accessor :estates, :duchies, :provinces
    
      def initialize
        self.kingdoms = []
        self.players  = []
        
        self.coppers = []
        self.silvers = []
        self.golds   = []
        
        self.estates   = []
        self.duchies   = []
        self.provinces = []
      end
  
      def seat(player)
        raise GameFull if full?
        self.players << player
        player.seat = players.size
      end
      
      def full?
        players.size >= Game.max_players
      end
      
      def total_victory_cards
        players.size < 3 ? 8 : 12
      end
      
      def deal
        1.upto(total_victory_cards) do
          self.estates   << Estate.new
          self.duchies   << Duchy.new
          self.provinces << Province.new
        end
      end
      
    end
  end
end