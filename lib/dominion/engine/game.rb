module Dominion
  module Engine
    class Game
      def self.max_players
        4 # For base set
      end
      
      def self.available_kingdoms
        Dominion.available_sets.collect{|s| s.available_kingdoms}.flatten
      end
      
      #########################################################################
      #                                 S E T U P                             #
      #########################################################################
      attr_accessor :kingdoms, :players, :turns, :current_turn
      attr_accessor :coppers, :silvers, :golds 
      attr_accessor :estates, :duchies, :provinces
    
      def initialize
        @players  = []
        
        @kingdoms = []
        
        @coppers = Pile.new Copper, 60
        @silvers = Pile.new Silver, 40
        @golds   = Pile.new Gold,   30
        
        @estates   = Pile.new Estate,   24
        @duchies   = Pile.new Duchy,    12
        @provinces = Pile.new Province, 12
      end
      
      def supplies
        kingdoms + [coppers, silvers, estates, duchies, provinces]
      end

      def seat(player)
        raise GameFull if players.size >= Game.max_players
        players << player
      end
      
      def deal
        pick_kingdoms
        if players.size == 2
          duchies.discard 4
          provinces.discard 4
        end
        players.each do |player|
          1.upto(7){player.gain coppers.shift}
          1.upto(3){player.gain estates.shift}
          player.draw_hand
        end
      end
      
      def pick_kingdoms
        Game.available_kingdoms.sort_by{rand}.first(10).each do |kingdom|
          kingdoms << Pile.new(kingdom, supply_size)
        end
      end
      
      def supply_size
        players.size > 2 ? 12 : 8
      end

      #########################################################################
      #                                P L A Y                                #
      #########################################################################
      def play
        while(!over?)
          turn = Turn.new next_player
          turn.take
          turns << turn
        end
        output_winner
      end
      
      def next_player
        return players.first if current_turn.nil? || current_turn.player == players.last
        players.each_with_index do |player, i|
          return players[i + 1] if player == current_turn.player
        end
      end
      
      def over?
        provinces.empty? || supplies.select{|s|s.empty?}.size >= 3
      end
      
      def output_winner
        
      end
      
    end
  end
end