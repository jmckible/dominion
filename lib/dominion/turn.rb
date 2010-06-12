module Dominion
  class Turn
    include EM::Deferrable
    
    attr_accessor :actions, :game, :in_play, :player
    attr_accessor :number_actions, :number_buys, :treasure
    attr_accessor :action_phase, :buy_phase
    
    #########################################################################
    #                           I N I T I A L I Z E                         #
    #########################################################################
    def initialize(game, player)
      @game           = game
      @player         = player
      @number_actions = 1
      @number_buys    = 1
      @actions        = Pile.new
      @treasure       = 0
      @in_play        = []
      @action_phase   = ActionPhase.new self
      @buy_phase      = BuyPhase.new self
    end
    
    #########################################################################
    #                            M O V E    C A R D S                       #
    #########################################################################
    def draw(number=1)
      drawn = player.draw number
      player.say "Drawing #{number}: #{drawn}"
      drawn
    end
    
    # Take to hand
    def take(card)
      game.remove card
      player.hand << card
    end
    
    # Gain to discard
    def gain(card)
      game.remove card
      player.gain card
    end
    
    # Trash in play from Feast or from hand for Chapel
    def trash(card)
      @in_play.delete card
      player.hand.delete card
      game.trash.unshift(card) unless game.trash.include?(card)
    end
    
    #########################################################################
    #                               A C T I O N S                           #
    #########################################################################
    def execute(action)
      @in_play << action unless in_play.include?(action)
      player.hand.delete action
      action.play self
      say_hand
      say_actions
    end
    
    def add_action(number=1)
      @number_actions = number_actions + number
    end
    alias :add_actions :add_action
    
    def other_players
      game.players.reject{|p| p == player}
    end
    
    #########################################################################
    #                             T R E A S U R E                           #
    #########################################################################
    def play_treasure
      player.hand.select{|card| card.is_a?(Treasure)}.each do |card|
        @in_play << card unless in_play.include?(card)
        player.hand.delete card
        @treasure = treasure + card.value
      end
    end
    
    def add_treasure(number)
      @treasure += number
    end
    
    def spend_treasure(number)
      @treasure = treasure - number
    end
    
    #########################################################################
    #                                  B U Y                                #
    #########################################################################

    
    def buy(card)
      spend_buy
      spend_treasure card.cost
      gain card
      broadcast "#{player} bought a #{card}"
    end
    
    def add_buy(number=1)
      @number_buys += number
    end
    alias :add_buys :add_buy
    
    def spend_buy
      @number_buys -= 1
    end
    
    
    #########################################################################
    #                           C L E A N    U P                            #
    #########################################################################
    def cleanup
      player.discard_hand
      while(!in_play.empty?)
        player.discard << in_play.shift 
      end
      player.draw_hand
      player.turns += 1
    end
    
    #########################################################################
    #                                  I / O                                #
    #########################################################################
    def broadcast(message)
      game.broadcast message
    end
    
    def say_hand
      player.say "Hand: #{player.hand.sort}"
    end
    
    def say_actions
      broadcast "#{number_actions} actions remaining"
    end
    
    def to_s() "#{player}'s Round #{player.turns + 1} turn" end
    
  end
end