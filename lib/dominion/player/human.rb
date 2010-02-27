module Dominion
  class Human < Player    
    attr_accessor :socket
    
    #########################################################################
    #                             I N I T I A L I Z E                       #
    #########################################################################
    def initialize(name, socket)
      @name   = name        
      @socket = socket
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
      choice = get_integer 'Choose a card to buy', 0, cards.size
      return nil if choice == 0
      cards[choice - 1]
    end
    
    #########################################################################
    #                               A C T I O N S                           #
    #########################################################################
    def choose_action
      return false if available_actions.empty?
      say_available_actions
      choice = get_integer 'Choose an Action', 0, available_actions.size
      return false if choice == 0
      available_actions[choice - 1]
    end
    
    #########################################################################
    #                                   I / O                               #
    #########################################################################
    def get_boolean(prompt)
      socket.puts "#{prompt} (Y/n)"
      answer = socket.gets.chomp
      while !['y', 'n', ''].include?(answer.downcase)
        socket.puts "Didn't get that. Please enter 'Y' or 'N'"
        socket.puts "#{prompt} (Y/n)"
        answer = socket.gets.chomp.downcase
      end
      answer == 'y' || answer == ''
    end
    
    def get_integer(prompt, lower, upper)
      socket.puts "#{prompt} (#{lower}-#{upper})"
      integer = socket.gets.chomp
      integer = integer.to_i
      while integer < lower || integer > upper
        socket.puts "Please enter a number between #{lower} and #{upper}"
        integer = socket.gets.chomp
        integer = integer.to_i
      end
      integer
    end
    
    def say(string)
      socket.puts string
    end
    
    def ask(string)
      say string
      socket.gets
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
      return unless game.server
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