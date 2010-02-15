require 'spec_helper'

describe Pile do
  
  it 'should create an empty pile' do
    pile = Pile.new
    pile.should be_empty
  end
  
  it 'should discard' do
    pile = Pile.new Estate, 10
    pile.discard 2
    pile.size.should == 8
  end
  
  it 'should find by type' do
    pile = Pile.new
    pile << Copper.new
    pile << Silver.new
    pile << Mine.new
    pile << ThroneRoom.new
    pile << Estate.new
    pile.should have(2).treasures
    pile.should have(2).actions
  end
  
end