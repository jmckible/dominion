require 'spec_helper'

describe Village do
  
  it 'should execute' do
    game = GameFactory.build
    turn = Turn.new game, game.players.next
    turn.execute Village.new
    turn.number_actions.should == 3
    turn.player.hand.size.should == 6
  end
  
end