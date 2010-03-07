require 'spec_helper'

describe Highlander do
  before(:each) do
    @highlander = Highlander.new 'Highlander'
    @highlander.wants = [Chancellor]
  end
  
  it 'should select a Chancellor' do
    chancellor = Chancellor.new
    @highlander.select_buy([Copper.new, chancellor]).should == chancellor
  end
  
  it 'should big money buy if action is set' do
    @highlander.action = Smithy.new
    province = Province.new
    @highlander.select_buy([Copper.new, province]).should == province
  end
  
end