require 'spec_helper'

describe Turn do
  before(:each) do
    @game, @player, @turn = GameFactory.build
  end
  
  it 'should know other players' do
    @turn.other_players.should == [@game.players[1], @game.players[2], @game.players[3]]
  end
  
  it 'should count treasure' do
    @player.hand = [Copper.new, Copper.new]   
    @turn.play_treasure
    @turn.treasure.should == 2
    @turn.in_play.size.should == 2
    @player.hand.should be_empty
  end
  
  it 'should discard' do
    card = @player.hand.first
    @turn.discard card
    @player.discard.should == [card]
    @player.hand.size.should == 4
  end
  
end