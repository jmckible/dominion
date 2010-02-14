require 'spec_helper'

describe Cellar do
  
  it 'should execute' do 
    game, player, turn = GameFactory.build
    player.stub!(:get_integer).and_return(1)
    turn.execute Cellar.new
    player.discard.size.should == 5
    player.hand.size.should == 5
    turn.number_actions.should == 2
  end
  
end