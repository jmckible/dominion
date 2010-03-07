require 'spec_helper'

describe Chapel do
  
  it 'should execute' do 
    game, player, turn = GameFactory.build
    player.stub!(:chapel_cards).and_return([player.hand.first])
    turn.execute Chapel.new
    game.trash.size.should == 1
    player.hand.size.should == 4
  end
  
end