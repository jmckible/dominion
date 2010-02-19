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
  
  it 'should discard' do
    card = @player.hand.first
    @turn.discard card
    @player.discard.should == [card]
    @player.hand.size.should == 4
  end
  
  it 'should select a card' do
    copper, silver, gold = Copper.new, Silver.new, Gold.new
    cards = [copper, silver, gold]
    
    @player.stub!(:ask).and_return("1\n")
    @turn.select_card(cards).should == copper
    
    @player.stub!(:ask).and_return("3\n")
    @turn.select_card(cards).should == gold
    
    @player.stub!(:ask).and_return("0\n")
    @turn.select_card(cards).should be_nil
    
    @player.stub!(:ask).and_return("4\n", "-1\n", "2\n")
    @turn.select_card(cards).should == silver
  end
  
end