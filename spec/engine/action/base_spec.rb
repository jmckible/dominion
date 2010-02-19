require 'spec_helper'

describe Base do
  it 'should have kingdoms' do
    Base.available_kingdoms.size.should == 19
  end
end