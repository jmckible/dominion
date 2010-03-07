include Dominion

big_money = BigMoney.new 'Big Money'

chancellor = Highlander.new 'Chancellor'
chancellor.wants = [Chancellor]

smithy = Highlander.new 'Smithy'
smithy.wants = [Smithy]

match = Match.new :use=>[Chancellor, Smithy]
match.players << big_money
match.players << chancellor
match.players << smithy

1.upto(100) do |i|
  scoreboard = match.play
  puts "Game #{i}\n#{scoreboard}\n"
end

puts "\n#{match}"