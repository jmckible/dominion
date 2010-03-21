class CardSelector
  include EM::Deferrable
  
  def self.choose_buy(player, cards)
    game = player.game
    
    player.say '0. Done'
    cards.each_with_index do |card, i|
      player.say "#{i+1}. #{card} ($#{card.cost}) - #{game.number_available card.class} left"
    end
    player.say "Choose a card to buy (0-#{cards.size})"
    
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
  

end