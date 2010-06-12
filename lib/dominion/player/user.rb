module Dominion
  class User < Player
    attr_accessor :uuid
    
    def initialize(options)
      @name = options[:name]        
      @uuid = options[:uuid]
      reset
    end
    
    #########################################################################
    #                               A C T I O N S                           #
    #########################################################################
    def play_action(turn)
      say '0. Done'
      available_actions.each_with_index do |option, i|
        say "#{i+1}. #{option}"
      end
      say "Choose an action to play"
      
      game.await CardSelect.new do |index|
        integer = index.to_i
        action = available_actions[integer]
        if action
          turn.number_actions = turn.number_actions - 1
          turn.execute action
          turn.action_phase.play
        else
          game.move_on
        end
      end
    end
    
    #########################################################################
    #                                   B U Y                               #
    #########################################################################
    def make_buy(turn)
      buyable = game.buyable(turn.treasure)
      
      say '0. Done'
      buyable.each_with_index do |option, i|
        say "#{i+1}. #{option} ($#{option.cost}) - #{game.number_available option.class} left"
      end
      say "Choose a card to buy"
      
      game.await CardSelect.new do |index|
        integer = index.to_i
        
        if integer != 0
          card = buyable[integer - 1]
          turn.buy card if card
        end
        
        if turn.number_buys == 0 || card.nil?
          game.move_on # End buy phase
        else
          turn.make_buy
        end
        
      end
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