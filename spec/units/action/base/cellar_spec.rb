require 'spec_helper'

describe Cellar do
  
  it 'should execute' do 
    game, player, turn = GameFactory.build
    player.stub!(:cellar_cards).and_return([Copper.new])
    
    turn.execute Cellar.new
    
    player.hand.size.should == 6
    turn.number_actions.should == 2
  end
  
end