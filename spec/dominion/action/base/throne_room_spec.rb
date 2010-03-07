require 'spec_helper'

describe ThroneRoom do
  
  it 'should execute' do
    game, player, turn = GameFactory.build
    smithy = Smithy.new
    player.hand << smithy
    throne_room = ThroneRoom.new
    turn.stub!(:select_card).and_return(smithy)
    
    turn.execute throne_room
    
    turn.in_play.collect{|c|c.to_s}.should == [throne_room.to_s, smithy.to_s]
    player.hand.size.should == 10
  end
  
  it 'should execute a card that trashes itself' do
    game, player, turn = GameFactory.build
    feast = Feast.new
    player.hand << feast
    
    copper = game.coppers.first
    silver = game.silvers.first
    turn.stub!(:select_card).and_return(feast, copper, silver)
    
    throne_room = ThroneRoom.new
    
    turn.execute throne_room
    
    game.trash.should == [feast]
    turn.in_play.should == [throne_room]
    player.discard.should == [silver, copper]
    player.hand.should_not be_include(feast)
    player.deck.should_not be_include(feast)
  end
  
end