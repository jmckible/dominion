big_money = BigMoney.new 'Big Money'
highlander = Highlander.new 'Highlander'
highlander.set_wishlist [Chancellor, Smithy, Festival, Laboratory, Market, CouncilRoom]

match = Match.new
match.players << big_money
match.players << highlander

1.upto(100) do |i|
  puts "Game #{i}"
  scoreboard = match.play
  puts "#{scoreboard}\n"
end

puts "\n#{match}"


#string = ''
#scoreboards.each_with_index do |scoreboard, i|
#  string << "Game #{i+1}\n"
#  scoreboard.scores.each do |score|
#    string << "  #{score.player} - #{score.points} points\n"
#  end
#  string << "  Winner: #{scoreboard.winner}\n"
#end
#string << "\n"