require 'spec_helper'

describe Chapel do
  
  it 'should execute' do 
    game, player, turn = GameFactory.build
    player.stub!(:get_integer).and_return(1, 1, 1, 1)
    turn.execute Chapel.new
    game.trash.size.should == 4
    player.hand.size.should == 1
  end
  
end