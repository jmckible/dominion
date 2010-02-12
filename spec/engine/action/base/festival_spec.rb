require 'spec_helper'

describe Festival do
  
  it 'should execute' do
    game = GameFactory.build
    turn = Turn.new game.next_player
    turn.execute Festival.new
    turn.number_actions.should == 3
    turn.number_buys.should == 2
    turn.treasure.should == 2
  end
  
end