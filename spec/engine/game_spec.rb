require 'spec_helper'

describe Game, 'setup' do
  
  it 'should seat the first player' do
    game = GameFactory.build 1
    game.should have(1).players
  end
  
  it 'should not seat too many players' do
    game = Game.new
    1.upto(4) do |i|
      game.seat Player.new(i)
    end
    game.should be_full
    running { game.seat Player.new('Fatty') }.should raise_error(Dominion::GameFull)
  end
  
  it 'should initialize starting cards' do
    game = Game.new
    1.upto(4){|i| game.seat Player.new(i) }
    game.deal
    game.should have(12).estates
    game.should have(12).duchies
    game.should have(12).provinces
  end
  
end

describe Game, 'gameplay' do
  it 'should know when its over' do
    GameFactory.build.should_not be_over
  end
end