require 'spec_helper'

describe Market do
  
  it 'should execute' do
    game = GameFactory.build
    turn = Turn.new game, game.next_player
    turn.execute Market.new
    turn.player.hand.size.should == 6
    turn.number_actions.should == 2
    turn.number_buys.should == 2
    turn.treasure.should == 1
  end
  
end