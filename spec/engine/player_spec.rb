require 'spec_helper'

describe Player do
  it 'should initialize with a name' do
    player = Player.new('Dave')
    player.name.should == 'Dave'
  end
end