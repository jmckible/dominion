require 'spec_helper'

describe Score do
  
  it 'should calculate' do
    player = Player.new 'Score'
    player.deck << Province.new
    player.deck << Estate.new
    player.deck << Curse.new
    score = Score.calculate player
    score.points.should == 6
  end
  
end