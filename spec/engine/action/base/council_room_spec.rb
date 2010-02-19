require 'spec_helper'

describe CouncilRoom do
  
  it 'should execute' do
    game, player, turn = GameFactory.build
    turn.execute CouncilRoom.new
    turn.player.hand.size.should == 9
    turn.number_buys.should == 2
    turn.other_players.each do |player|
      player.hand.size.should == 6
    end
  end
  
end