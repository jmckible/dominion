require 'spec_helper'

describe Adventurer do
  
  it 'should execute' do
    game, player, turn = GameFactory.build
    silver = Silver.new
    gold = Gold.new
    village = Village.new
    smithy = Smithy.new
    player.deck.unshift silver
    player.deck.unshift village
    player.deck.unshift smithy
    player.deck.unshift gold
    
    turn.execute Adventurer.new
    player.hand.size.should == 7
    player.hand.should be_include(silver)
    player.hand.should be_include(gold)
    
    player.discard.should == [village, smithy]
  end
  
end