require 'spec_helper'

describe CouncilRoom do
  
  it 'should execute' do
    game, player, turn = GameFactory.build
    turn.execute CouncilRoom.new
    turn.player.hand.size.should == 9
    turn.number_buys.should == 2
    game.players[1].hand.size.should == 6
    game.players[2].hand.size.should == 6
    game.players[3].hand.size.should == 6
  end
  
end