require 'spec_helper'

describe Pile do
  
  it 'should create an empty pile' do
    pile = Pile.new
    pile.should be_empty
  end
  
  it 'should create a pile with default size' do
    pile = Pile.new Thief
    pile.size.should == 10
  end
  
  it 'should create a pile specific size' do
    pile = Pile.new Estate, 20
    pile.size.should == 20
  end
  
  it 'should discard' do
    pile = Pile.new Estate, 10
    pile.discard 2
    pile.size.should == 8
  end
  
end