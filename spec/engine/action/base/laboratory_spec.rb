require 'spec_helper'

describe Laboratory do
  
  it 'should execute' do
    game = GameFactory.build
    turn = Turn.new game.next_player
    turn.execute Laboratory.new
    turn.number_actions.should == 2
    turn.player.hand.size.should == 7
  end
  
end