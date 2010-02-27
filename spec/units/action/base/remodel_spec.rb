require 'spec_helper'

describe Remodel do
  
  it 'should execute' do
    game, player, turn = GameFactory.build
    village = Village.new
    player.hand << village
    duchy = game.duchies.first
    player.stub!(:select_card).and_return(village, duchy)
    turn.execute Remodel.new
    game.trash.should == [village]
    player.hand.should be_include(duchy)
    game.duchies.should_not be_include(duchy)
  end
  
end