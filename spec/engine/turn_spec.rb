require 'spec_helper'

describe Turn do
  
  it 'should know other players' do
    game = GameFactory.build
    turn = Turn.new game, game.players.first
    turn.other_players.should == [game.players[1], game.players[2], game.players[3]]
  end
  
end