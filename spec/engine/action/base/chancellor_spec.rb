require 'spec_helper'

describe Chancellor do
  
  it 'should execute with discard' do
    game = GameFactory.build
    player = game.players.next
    turn = Turn.new game, player
    player.stub!(:get_boolean).and_return(true)
    player.should_receive(:discard_deck)
    turn.execute Chancellor.new
    turn.treasure.should == 2
  end
  
  it 'should execute without discard' do
    game = GameFactory.build
    player = game.players.next
    turn = Turn.new game, player
    player.stub!(:get_boolean).and_return(false)
    player.should_not_receive(:discard_deck)
    turn.execute Chancellor.new
    turn.treasure.should == 2
  end
  
end