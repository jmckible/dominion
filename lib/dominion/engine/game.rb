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
        kingdoms = []
        1.upto(10){kingdoms << Array.new}
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
        players.each{|p| p.deck.setup}
      end
      
      def play
        while(!over?)
          
        end
      end
      
      def empty_piles
        []
      end
      
      def over?
        provinces.empty? || empty_piles.size >= 3
      end
      
    end
  end
end