require 'spec_helper'

describe Seaside do
  it 'should have kingdoms' do
    Seaside.available_kingdoms.size.should == 2
  end
end