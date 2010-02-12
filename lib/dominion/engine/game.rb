module Dominion
  module Engine
    class Game
      def self.max_players
        4 # For base set
      end
      
      #########################################################################
      #                                 S E T U P                             #
      #########################################################################
      attr_accessor :kingdoms, :players
      attr_accessor :coppers, :silvers, :golds 
      attr_accessor :estates, :duchies, :provinces
    
      def initialize
        self.players  = []
        
        kingdoms = []
        1.upto(10){kingdoms << Pile.new}
        
        self.coppers = Pile.new Copper, 60
        self.silvers = Pile.new Silver, 40
        self.golds   = Pile.new Gold,   30
        
        self.estates   = Pile.new Estate,   24
        self.duchies   = Pile.new Duchy,    12
        self.provinces = Pile.new Province, 12
      end

      def seat(player)
        raise GameFull if players.size >= Game.max_players
        self.players << player
      end
      
      def deal
        if players.size == 2
          duchies.discard 4
          provinces.discard 4
        end
        players.each do |player|
          1.upto(7){player.gain coppers.pop}
          1.upto(3){player.gain estates.pop}
        end
      end
      
      #########################################################################
      #                                P L A Y                                #
      #########################################################################
      def play
        while(!over?)
          
        end
      end
      
      def empty_piles
        
      end
      
      def over?
        provinces.empty? || empty_piles.size >= 3
      end
      
    end
  end
end