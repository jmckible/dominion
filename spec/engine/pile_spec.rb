require 'spec_helper'

describe Pile do
  
  it 'should fill with cards' do
    pile = Pile.new
    pile.should be_empty
    pile = Pile.new Estate, 20
    pile.size.should == 20
  end
  
  it 'should discard' do
    pile = Pile.new Estate, 10
    pile.discard 2
    pile.size.should == 8
  end
  
end