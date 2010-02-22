require 'spec_helper'

describe Warehouse do
  
  it 'should execute' do
    game, player, turn = GameFactory.build
    turn.execute Warehouse.new
    turn.number_actions.should == 2
    player.hand.size.should == 5
    player.deck.size.should == 2
    player.discard.size.should == 3
  end
  
end