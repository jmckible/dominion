require 'spec_helper'

describe Workshop do
  
  it 'should execute' do
    game, player, turn = GameFactory.build
    workshop = Workshop.new
    copper = game.coppers.first
    turn.stub!(:select_card).and_return(copper)
    turn.execute workshop
    player.discard.first.should == copper
    game.coppers.size.should == 31
  end
  
end