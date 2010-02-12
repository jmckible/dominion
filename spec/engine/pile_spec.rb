require 'spec_helper'

describe Pile do
  
  it 'should fill with cards' do
    pile = Pile.new
    pile.fill Estate, 20
    pile.card_type.should == Estate
    pile.should have(20).cards
  end
  
end