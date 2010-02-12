require 'spec_helper'

describe Player do
  
  it 'should initialize' do
    player = Player.new 'Dave'
    player.name.should == 'Dave'
    player.deck.should be_a(Deck)
  end
  
  it 'should gain' do
    player = Player.new 'Player'
    copper = Copper.new
    player.gain copper
    player.discard.should == [copper]
  end
  
  it 'should draw an opening hand' do
    game = GameFactory.build
    game.players.first.hand.size.should == 5
  end
  
  it 'should determine available actions' do
    player = Player.new 'John'
    player.should have(0).available_actions
    player.hand << Village.new
    player.hand << Smithy.new
    player.hand << Copper.new
    player.hand << Gardens.new
    player.hand << Estate.new
    player.should have(2).available_actions
  end
  
  it 'should discard deck' do
    game = GameFactory.build
    player = game.players.first
    player.deck.size.should == 5
    player.discard.size.should == 0
    player.discard_deck
    player.deck.size.should == 0
    player.discard.size.should == 5
  end
  
end