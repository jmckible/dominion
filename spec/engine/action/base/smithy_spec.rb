require 'spec_helper'

describe Smithy do
  
  it 'should execute' do
    game = GameFactory.build
    turn = Turn.new game.next_player
    turn.execute Smithy.new
    turn.player.hand.size.should == 8
  end
  
end