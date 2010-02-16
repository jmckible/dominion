big_money = BigMoney.new 'Big Money'
highlander = Highlander.new 'Highlander'
highlander.set_wishlist [Chancellor, Smithy, Festival, Laboratory, Market, CouncilRoom]

match = Match.new
match.players << big_money
match.players << highlander

1.upto(100) do
  print '.'
  match.play
end

puts "\n#{match}"