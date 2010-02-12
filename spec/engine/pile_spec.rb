require 'spec_helper'

describe Pile do
  
  it 'should fill with cards' do
    pile = Pile.new
    pile.fill Estate, 20
    pile.size.should == 20
  end
  
end