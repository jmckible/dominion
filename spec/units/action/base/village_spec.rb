require 'spec_helper'

describe Village do
  
  it 'should execute' do
    game, player, turn = GameFactory.build
    turn.execute Village.new
    turn.number_actions.should == 3
    turn.player.hand.size.should == 6
  end
  
end