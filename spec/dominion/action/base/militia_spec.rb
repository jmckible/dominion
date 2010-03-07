require 'spec_helper'

describe Militia do
  
  it 'should execute' do
    game, player, turn = GameFactory.build
    
    turn.other_players.each do |player|
      player.stub!(:ask).and_return("1\n")
    end
    
    turn.execute Militia.new
    turn.treasure.should == 2
    
    turn.other_players.each do |player|
      player.hand.size.should == 3
    end
  end
  
end