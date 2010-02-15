require 'spec_helper'

describe Moneylender do
  before(:each) do
    @game, @player, @turn = GameFactory.build
  end
  
  it 'should execute' do
    copper = @player.hand.treasures.first # Gotta be a copper
    @player.stub!(:get_boolean).and_return(true)
    @turn.execute Moneylender.new
    @turn.treasure.should == 3
    @player.hand.should_not be_include(copper)
    @game.trash.should == [copper]
  end
  
  it 'should skip execute' do
    copper = @player.hand.treasures.first
    @player.stub!(:get_boolean).and_return(false)
    @turn.execute Moneylender.new
    @turn.treasure.should == 0
    @player.hand.should be_include(copper)
    @game.trash.should == []
  end
  
end