require 'spec_helper'

describe Turn do
  before(:each) do
    @game, @player, @turn = GameFactory.build
  end
  
  it 'should know other players' do
    @turn.other_players.should_not be_include(@player)
  end
  
  it 'should take card to hand' do
    copper = @game.coppers.first
    @turn.take copper
    @player.hand.should be_include(copper)
    @game.coppers.should_not be_include(copper)
  end
  
  it 'should count treasure' do
    @player.hand = [Copper.new, Copper.new]   
    @turn.play_treasure
    @turn.treasure.should == 2
    @turn.in_play.size.should == 2
    @player.hand.should be_empty
  end
  
end