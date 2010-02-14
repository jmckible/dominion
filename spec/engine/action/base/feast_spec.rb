require 'spec_helper'

describe Feast do
  
  it 'should execute' do
    game, player, turn = GameFactory.build
    duchy = game.duchies.first
    feast = Feast.new
    feast.stub!(:select_card).and_return(duchy)
    
    turn.execute feast
    game.trash.should == [feast]
    player.discard.should == [duchy]
  end
  
end