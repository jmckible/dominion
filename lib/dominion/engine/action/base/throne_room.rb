module Dominion
  module Engine
    class ThroneRoom < Action
      
      attr_accessor :available_cards
      
      def cost() 4 end
      def to_s() 'Throne Room' end
      
      def play(turn)
        @available_cards = turn.player.hand.select{|c| c.is_a? Action}
        card = select_card
        if card
          turn.broadcast "#{turn.player} selected #{card} to Throne Room" unless turn.game.silent
          turn.execute card
          turn.execute card
        end
      end

      def select_card
        show_card_list
        choice = turn.player.gets.chomp.to_i
        while choice < 0 || choice > available_cards.size
          turn.player.puts 'Choose a valid card'
          show_card_list
          choice = turn.player.gets.chomp.to_i
        end
        return nil if choice == 0
        available_cards[choice - 1]
      end

      def show_card_list
        turn.player.puts 'Choose a card'
        turn.player.puts '0. None'
        available_cards.each_with_index do |card, i|
          turn.player.puts "#{i+1}. #{card}"
        end
      end
      
    end
  end
end