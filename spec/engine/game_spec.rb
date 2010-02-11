require 'spec_helper'

describe Game do
  
  it 'should seat the first player' do
    game = Game.new
    player = Player.new 'Dave'
    game.seat player
    game.should have(1).players
    player.seat.should == 1
  end
  
  it 'should not seat too many players' do
    game = Game.new
    1.upto(4) do |i|
      game.seat Player.new(i)
    end
    game.should be_full
    running { game.seat Player.new('Fatty') }.should raise_error(Dominion::GameFull)
  end
  
  
end