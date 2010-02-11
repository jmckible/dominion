require 'spec_helper'

describe Player do
  it 'should initialize a name' do
    Player.new('Dave').name.should == 'Dave'
  end
end