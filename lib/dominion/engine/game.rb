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
      attr_accessor :server, :kingdoms, :players, :trash
      attr_accessor :coppers, :silvers, :golds 
      attr_accessor :estates, :duchies, :provinces
    
      def initialize(server=nil)
        @server = server
        @players  = Wheel.new
        @kingdoms = []
        @trash    = []
        
        @coppers = Pile.new Copper, 60
        @silvers = Pile.new Silver, 40
        @golds   = Pile.new Gold,   30
        
        @estates   = Pile.new Estate,   24
        @duchies   = Pile.new Duchy,    12
        @provinces = Pile.new Province, 12
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
        players.start
      end
      
      def seat(player)
        raise GameFull if players.size >= Game.max_players
        players << player
        player.game = self
      end
      
      def pick_kingdoms
        Game.available_kingdoms.sort_by{rand}.first(10).each do |kingdom|
          kingdoms << Pile.new(kingdom, supply_size)
        end
      end
      
      #########################################################################
      #                              S U P P L I E S                          #
      #########################################################################
      def supplies
        kingdoms + [coppers, silvers, golds, estates, duchies, provinces]
      end
      
      def number_available(card_type)
        supplies.flatten.count{|card| card.is_a? card_type}
      end
      
      def supply_size
        players.size > 2 ? 12 : 8
      end
      
      def buyable(treasure)
        cards = Pile.new
        supplies.each do |pile|
          cards << pile.first if pile.first && pile.first.cost <= treasure
        end
        cards.sort
      end
      
      def remove(card)
        supplies.each{ |pile| pile.delete card }
      end

      #########################################################################
      #                                P L A Y                                #
      #########################################################################
      def play
        deal
        say_kingdoms
        players.round = 0
        while(!over?)
          player = players.next
          players.round = players.round + 1 if players.first == player 
          Turn.new(self, player).take
        end
        players.each do |player|
          player.combine_cards
          player.say_score
        end
      end
      
      def over?
        provinces.empty? || supplies.select{|s|s.empty?}.size >= 3
      end
      
      #########################################################################
      #                               O U T P U T                             #
      #########################################################################
      def say_kingdoms
        return unless server
        server.broadcast "\nAvailable Kingdoms this game:"
        names = []
        kingdoms.each do |pile|
          names << pile.first.to_s if pile.first
        end
        server.broadcast names.sort
      end
      
      def broadcast(message)
        return unless server
        server.broadcast message
      end
      
    end
  end
end