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
        1.upto(10){kingdoms << Pile.new}
        self.players  = []
        
        self.coppers = Pile.new
        self.silvers = Pile.new
        self.golds   = Pile.new
        
        self.estates   = Pile.new
        self.duchies   = Pile.new
        self.provinces = Pile.new
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
        self.estates.fill Estate, total_victory_cards
        self.duchies.fill Duchy, total_victory_cards
        self.provinces.fill Province, total_victory_cards
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