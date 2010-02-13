require 'spec_helper'

describe Chapel do
  
  it 'should execute' do 
    game = GameFactory.build
    player = game.players.first
    turn = Turn.new game, player
    Game.stub!(:get_integer).and_return(1, 1, 1, 1)
    turn.execute Chapel.new
    game.trash.size.should == 4
    player.hand.size.should == 1
  end
  
end