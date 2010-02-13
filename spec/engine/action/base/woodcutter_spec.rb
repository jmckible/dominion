require 'spec_helper'

describe Woodcutter do
  
  it 'should execute' do
    game = GameFactory.build
    turn = Turn.new game, game.players.next
    turn.execute Woodcutter.new
    turn.number_buys.should == 2
    turn.treasure.should == 2
  end
  
end