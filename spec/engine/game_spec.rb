require 'spec_helper'

describe Game, 'setup' do
  
  it 'should have all kingdoms from all sets' do
    Game.should have(25).available_kingdoms
  end
  
  it 'should seat the first player' do
    game = GameFactory.build 1
    game.should have(1).players
  end
  
  it 'should not seat too many players' do
    game = Game.new
    1.upto(4){|i| game.seat Player.new("Player #{i}") }
    running { game.seat Player.new('Left out') }.should raise_error(Dominion::GameFull)
  end
  
  it 'should have supply piles' do
    game = GameFactory.build
    game.should have(15).supplies
  end
  
  it 'should initialize starting cards' do
    game = GameFactory.build
    game.should have(12).estates
    game.should have(12).duchies
    game.should have(12).provinces
    game.should have(40).silvers
    game.should have(30).golds
    game.should have(32).coppers
    game.kingdoms.size.should == 10
    game.kingdoms.each{|k| k.size.should == 12}
    game.players.each{|p| p.should have(5).hand }
  end

end

describe Game, 'gameplay' do
  it 'it should start playable' do
    game = GameFactory.build
    game.should_not be_over
  end
  
  it 'should be over by way of provinces' do
    game = GameFactory.build
    game.provinces = []
    game.should be_over
  end
  
  it 'should be with three empty supplies' do
    game = GameFactory.build
    game.kingdoms[0] = []
    game.should_not be_over
    game.duchies = []
    game.should_not be_over
    game.silvers = []
    game.should be_over
  end
  
  it 'should find the next player' do
    game = GameFactory.build
    game.next_player.should == game.players.first
    game.current_turn = Turn.new(game, game.players[1])
    game.next_player.should == game.players[2]
    game.current_turn = Turn.new(game, game.players[3])
    game.next_player.should == game.players.first
  end
  
  it 'should find buyable with budget' do
    game = GameFactory.build
    game.buyable(8).size.should == 15
    game.buyable(0).size.should == 1
  end
  
  it 'should remove a card' do
    game = GameFactory.build
    card = game.coppers.first
    game.remove card
    game.coppers.size.should == 31
  end
  
end