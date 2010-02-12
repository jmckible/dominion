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
  
end