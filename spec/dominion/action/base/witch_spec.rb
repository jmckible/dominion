require 'spec_helper'

describe Witch do
  
  it 'should execute' do
    game, player, turn = GameFactory.build
    turn.execute Witch.new
    turn.other_players.each do |p|
      p.discard.first.should be_is_a(Curse)
    end
    player.hand.size.should == 7
  end
  
end