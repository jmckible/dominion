require 'spec_helper'

describe Bazaar do
  
  it 'should execute' do
    game, player, turn = GameFactory.build
    turn.execute Bazaar.new
    turn.number_actions.should == 3
    turn.treasure.should == 1
    player.hand.size.should == 6
  end
  
end