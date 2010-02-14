require 'spec_helper'

describe Woodcutter do
  
  it 'should execute' do
    game, player, turn = GameFactory.build
    turn.execute Woodcutter.new
    turn.number_buys.should == 2
    turn.treasure.should == 2
  end
  
end