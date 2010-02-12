require 'spec_helper'

describe Village do
  
  it 'should execute' do
    game = GameFactory.build
    turn = Turn.new game.next_player
    turn.execute Village.new
    turn.number_actions.should == 2
    turn.player.hand.size.should == 6
  end
  
end