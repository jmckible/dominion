module Dominion
  
  class Game
    def self.available_kingdoms(options={})
      except = options[:except] || []
      kingdoms = Dominion.available_sets.collect{|s| s.available_kingdoms}.flatten
      kingdoms.reject do |kingdom|
        except.include? kingdom
      end
    end
    
    #########################################################################
    #                                 S E T U P                             #
    #########################################################################
    attr_accessor :use, :scoreboard
    attr_accessor :kingdoms, :players, :trash
    attr_accessor :coppers, :silvers, :golds 
    attr_accessor :estates, :duchies, :provinces, :curses
    attr_accessor :deferrable_stack, :number_players, :id
  
    def initialize(options={})
      @players   = Wheel.new
      @use       = options[:use] || []
      @kingdoms  = []
      @trash     = []
      
      @coppers   = Pile.new Copper, 60
      @silvers   = Pile.new Silver, 40
      @golds     = Pile.new Gold,   30
      
      @estates   = Pile.new Estate,   24
      @duchies   = Pile.new Duchy,    12
      @provinces = Pile.new Province, 12
      @curses    = Pile.new Curse, 30
      
      @socket    = options[:socket]
      @id        = options[:id]
      @number_players = options[:number_players] || 2
      
      @deferrable_stack = []
    end
    
    def deal
      pick_kingdoms
      if players.size == 2
        duchies.discard 4
        provinces.discard 4
        curses.discard 10
      end
      players.each do |player|
        1.upto(7){player.gain coppers.shift}
        1.upto(3){player.gain estates.shift}
        player.draw_hand
      end
      players.choose_starting
    end
    
    def seat(player)
      players << player
      player.game = self
      player
    end
    
    def pick_kingdoms
      use.each do |kingdom|
        kingdoms << Pile.new(kingdom, supply_size)
      end
      
      Game.available_kingdoms(:except=>use).sort_by{rand}.first(10 - kingdoms.size).each do |kingdom|
        kingdoms << Pile.new(kingdom, supply_size)
      end
    end
    
    #########################################################################
    #                              S U P P L I E S                          #
    #########################################################################
    def supplies
      kingdoms + [coppers, silvers, golds, estates, duchies, provinces, curses]
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
      if over?
        broadcast Scoreboard.calculate(self)
      else
        turn = Turn.new self, players.next
        deferrable_stack << turn
        turn.callback { play }

        action_phase = ActionPhase.new(turn)
        deferrable_stack << action_phase
        action_phase.callback do
          buy_phase = BuyPhase.new(turn)
          deferrable_stack << buy_phase
          buy_phase.callback do
            turn.cleanup
            move_on
          end
          turn.buy_loop
        end
        
        turn.action_loop
      end
    end
    
    def start
      seat BigMoney.new 'Big Money'
      await EM::DefaultDeferrable.new do |hash|
        seat User.new(hash)
        EventMachine::Timer.new(1) do # Wait for redirect
          deal
          say_kingdoms
          play
        end
      end
    end
    
    def await(deferrable, &block)
      deferrable_stack << deferrable
      deferrable.callback &block
      deferrable
    end

    def notify(data)
      deferrable = deferrable_stack.pop
      deferrable.succeed data
    end
    
    def move_on
      deferrable = deferrable_stack.pop
      deferrable.succeed
    end
    
    def seating?
      players.size < number_players
    end
    
    def over?
      provinces.empty? || supplies.select{|s|s.empty?}.size >= 3
    end
    
    #########################################################################
    #                               O U T P U T                             #
    #########################################################################

    
    def say_kingdoms
      broadcast "\nAvailable Kingdoms this game:"
      names = []
      kingdoms.each do |pile|
        names << pile.first.to_s if pile.first
      end
      names.sort.each{|name| broadcast name }
    end
    
    def broadcast(message)
      MQ.fanout(queue).publish message
    end
    
    def queue() "game-#{id}" end
      
    def to_s() "Game #{id}" end
      
    def say_stack(append='')
      puts "[#{append}] Deferrable Stack: #{deferrable_stack.size}"
      deferrable_stack.each{|d| puts d}
      puts "\n"
    end
    
  end
end