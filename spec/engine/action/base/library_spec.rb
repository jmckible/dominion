require 'spec_helper'

describe Library do
  before(:each) do
    @game, @player, @turn = GameFactory.build
  end
  
  it 'should execute without actions' do
    @turn.execute Library.new
    @player.hand.size.should == 7
    @player.deck.size.should == 3
  end
  
  it 'should execute with a discard' do
    remodel = Remodel.new
    @player.deck.unshift remodel
    @player.stub!(:get_boolean).and_return(true)
    
    @turn.execute Library.new
    
    @player.hand.size.should == 7
    @player.deck.size.should == 3
    @player.discard.should == [remodel]
  end
  
  
end