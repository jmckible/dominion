require 'spec_helper'

describe Game, 'setup' do
  
  it 'should have all kingdoms from all sets' do
    Game.should have(18).available_kingdoms
  end
  
  it 'should start a game with specific kingdom' do
    game = Game.new :picks=>[Chapel]
    game.pick_kingdoms
    game.kingdoms.first.card_type.should == Chapel
  end
  
  it 'should seat the first player' do
    game = GameFactory.create 1
    game.should have(1).players
    game.players.first.game.should == game
  end
  
  it 'should not seat too many players' do
    game = Game.new
    1.upto(4){|i| game.seat Player.new("Player #{i}") }
    running { game.seat Player.new('Left out') }.should raise_error(Dominion::GameFull)
  end
  
  it 'should have supply piles' do
    game = GameFactory.create 4
    game.should have(16).supplies
  end
  
  it 'should initialize starting cards with four players' do
    game = GameFactory.create 4
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
  
  it 'should initialize starting cards with two players' do
    game = GameFactory.create 2
    game.should have(18).estates
    game.should have(8).duchies
    game.should have(8).provinces
    game.should have(40).silvers
    game.should have(30).golds
    game.should have(46).coppers
    game.kingdoms.size.should == 10
    game.kingdoms.each{|k| k.size.should == 8}
    game.players.each{|p| p.should have(5).hand }
  end

end

describe Game, 'gameplay' do
  it 'it should start playable' do
    game = GameFactory.create 4
    game.should_not be_over
  end
  
  it 'should be over by way of provinces' do
    game = GameFactory.create 4
    game.provinces = []
    game.should be_over
  end
  
  it 'should be with three empty supplies' do
    game = GameFactory.create 4
    game.kingdoms[0] = []
    game.should_not be_over
    game.duchies = []
    game.should_not be_over
    game.silvers = []
    game.should be_over
  end
  
  it 'should find buyable with budget' do
    game = GameFactory.create 4
    game.buyable(8).size.should == 16
    game.buyable(0).size.should == 1
  end
  
  it 'should remove a card' do
    game = GameFactory.create 4
    card = game.coppers.first
    game.remove card
    game.coppers.size.should == 31
  end
  
  it 'should count the number of available' do
    game = GameFactory.create 4
    game.number_available(Copper).should == 32
  end
  
end