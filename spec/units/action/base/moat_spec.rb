require 'spec_helper'

describe Moat do
  
  it 'should execute' do
    game, player, turn = GameFactory.build
    turn.execute Moat.new
    player.hand.size.should == 7
  end
  
end