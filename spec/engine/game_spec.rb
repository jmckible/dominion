require 'spec_helper'

describe Game do
  it 'initialize with starting players' do
    Game.new(3).players.size.should == 3
  end
end