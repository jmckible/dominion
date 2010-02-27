require 'spec_helper'

describe Smithy do
  
  it 'should execute' do
    game, player, turn = GameFactory.build
    turn.execute Smithy.new
    turn.player.hand.size.should == 8
  end
  
end