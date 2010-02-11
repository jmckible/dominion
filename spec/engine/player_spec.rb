require 'spec_helper'

describe Player do
  it 'should initialize' do
    player = Player.new('Dave')
    player.name.should == 'Dave'
    player.deck.should be_a(Deck)
  end
end