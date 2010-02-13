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
      attr_accessor :kingdoms, :players, :trash
      attr_accessor :coppers, :silvers, :golds 
      attr_accessor :estates, :duchies, :provinces
      attr_accessor :silent, :server
    
      def initialize(server)
        @players  = Wheel.new
        @kingdoms = []
        @trash    = []
        
        @coppers = Pile.new Copper, 60
        @silvers = Pile.new Silver, 40
        @golds   = Pile.new Gold,   30
        
        @estates   = Pile.new Estate,   24
        @duchies   = Pile.new Duchy,    12
        @provinces = Pile.new Province, 12
        
        @silent = false
        @server = server
      end
      
      def setup
        1.upto(Input.get_integer("How many players", 2, 4)) do |i|
          puts "Enter Player #{i}'s Name:"
          name = gets.chomp
          player = Player.new name
          seat player
        end
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

      def seat(player)
        raise GameFull if players.size >= Game.max_players
        players << player
      end
      
      def supply_size
        players.size > 2 ? 12 : 8
      end
      
      def buyable(treasure)
        cards = []
        supplies.each do |pile|
          unless pile.empty?
            cards << pile.first if pile.first.cost <= treasure
          end
        end
        cards.sort_by{|c| c.cost}
      end
      
      def remove(card)
        supplies.each do |pile|
          pile.delete card
        end
      end

      #########################################################################
      #                                P L A Y                                #
      #########################################################################
      def play
        setup if players.empty?
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
      
      def next_player
        return players.first if current_turn.nil? || current_turn.player == players.last
        players.each_with_index do |player, i|
          return players[i + 1] if player == current_turn.player
        end
      end
      
      def over?
        provinces.empty? || supplies.select{|s|s.empty?}.size >= 3
      end
      
      #########################################################################
      #                               O U T P U T                             #
      #########################################################################
      def say_kingdoms
        return if silent
        server.broadcast "\nAvailable Kingdoms this game:"
        names = []
        kingdoms.each do |pile|
          names << pile.first.to_s if pile.first
        end
        server.broadcast names.sort
      end
      
      def broadcast(message)
        server.broadcast message
      end
      
    end
  end
end