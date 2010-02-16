require 'spec_helper'

describe Chancellor do
  
  it 'should execute with discard' do
    game, player, turn = GameFactory.build
    player.stub!(:use_chancellor?).and_return(true)
    player.should_receive(:discard_deck)
    turn.execute Chancellor.new
    turn.treasure.should == 2
  end
  
  it 'should execute without discard' do
    game, player, turn = GameFactory.build
    player.stub!(:use_chancellor?).and_return(false)
    player.should_not_receive(:discard_deck)
    turn.execute Chancellor.new
    turn.treasure.should == 2
  end
  
end