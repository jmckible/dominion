big_money = BigMoney.new 'Big Money'
highlander = Highlander.new 'Highlander'
highlander.set_wishlist [Chancellor, Smithy, Festival, Laboratory, Market, CouncilRoom]

game = Game.new
game.seat big_money
game.seat highlander

puts game.play