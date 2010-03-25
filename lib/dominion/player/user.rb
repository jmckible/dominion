module Dominion
  class User < Player
    attr_accessor :uuid
    
    def initialize(options)
      @name = options['name']        
      @uuid = options['uuid']
      reset
    end
    
    #########################################################################
    #                                   B U Y                               #
    #########################################################################
    def select_buy(cards) 
      say '0. Done'
      cards.each_with_index do |card, i|
        say "#{i+1}. #{card} ($#{card.cost}) - #{game.number_available card.class} left"
      end
      say "Choose a card to buy (0-#{cards.size})"
      
      game.deferred_block = EM::DefaultDeferrable.new
      game.deferred_block.callback do |data|
        integer = data.to_i
        
        # This should redo if out of bounds
        integer = 0 if integer < 0
        integer = cards.size if integer > cards.size
        card = integer == 0 ? nil : cards[integer-1]
        
        turn.deferred_block.suceeded card
      end
    end
    
    def buy_phase(turn)
      BuyPhase.new turn
    end
    
    #########################################################################
    #                               A C T I O N S                           #
    #########################################################################
    def action_phase(turn)
      action_phase = ActionPhase.new turn
      action_phase.callback do
        
        if available_actions.empty?
          
        else
          
        end
      end
      
      action_phase
      
      
      #action_loop = ActionLoop.spin turn
      #action_loop.callback do 
      #  if available_actions.empty?
      #    game.move_on # Advance turn past action phase
      #  else
      #    action_loop turn
      #  end
      #end
      #action_loop
    end
    
    #########################################################################
    #                                   I / O                               #
    #########################################################################
    def get_boolean(prompt)
      say "#{prompt} (Y/n)"
      answer = game.gets
      while !['y', 'n', ''].include?(answer.downcase)
        say "Didn't get that. Please enter 'Y' or 'N'"
        say "#{prompt} (Y/n)"
        answer = game.gets.downcase
      end
      answer == 'y' || answer == ''
    end
    
    def get_integer(prompt, lower, upper)
      say "#{prompt} (#{lower}-#{upper})"
      game.df = EM::DefaultDeferrable.new
      game.df.callback do |data|
        integer = data.to_i
        #while integer < lower || integer > upper
        #  say "Please enter a number between #{lower} and #{upper}"
        #  integer = game.gets
        #  integer = integer.to_i
        #end
        integer = lower if integer < lower || integer > upper
        integer
      end
    end
    
    def say(string)
      #Should only fanout to player only queue
      #MQ.fanout(game.queue).publish string
      game.broadcast string
    end
    
    def broadcast(string)
      game.broadcast string
    end
    
    def say_card_list(cards, force=false)
      say '0. Done' unless force
      cards.each_with_index do |card, i|
        say "#{i+1}. #{card}"
      end
    end
    
    def say_available_actions
      say '0. Done'
      available_actions.each_with_index do |card, i|
        say "#{i+1}. #{card}\n"
      end
    end
    
    def select_card(cards, options={})
      message = options[:message] || 'Choose a card'
      force   = options[:force]   || false
      
      say_card_list cards, force
      choice = ask(message).chomp.to_i
      while (force ? (choice < 1) : (choice < 0)) || choice > cards.size
        say_card_list cards, force
        choice = ask('Choose a valid card').chomp.to_i
      end
      return nil if choice == 0 && !force
      cards[choice - 1]
    end
  
  end
end