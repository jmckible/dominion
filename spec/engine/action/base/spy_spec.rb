require 'spec_helper'

describe Spy do
  
  it 'should execute' do
    game, player, turn = GameFactory.build
    silver = Silver.new
    player.deck.unshift silver
    gold = Gold.new
    player.deck.unshift gold
    
    turn.execute Spy.new
    
    turn.number_actions.should == 2
    player.hand.size.should == 6
  end
  
end