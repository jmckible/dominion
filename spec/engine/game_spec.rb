require 'spec_helper'

describe Game, 'setup' do
  
  it 'should seat the first player' do
    game = GameFactory.build 1
    game.should have(1).players
  end
  
  it 'should not seat too many players' do
    game = Game.new
    1.upto(4) do |i|
      game.seat Player.new(i)
    end
    running { game.seat Player.new('Left out') }.should raise_error(Dominion::GameFull)
  end
  
  it 'should initialize starting cards' do
    game = Game.new
    1.upto(4){|i| game.seat Player.new(i) }
    game.deal
    game.should have(12).estates
    game.should have(12).duchies
    game.should have(12).provinces
    game.players.each{|p| p.should have(5).hand }
  end
  
  it 'should have supply piles' do
    Game.new.should have(15).supplies
  end
  
end

describe Game, 'gameplay' do
  it 'should know when its over' do
    GameFactory.build.should_not be_over
  end
  
  it 'should find the next player' do
    game = GameFactory.build
    game.next_player.should == game.players.first
    game.current_turn = Turn.new(game.players[1])
    game.next_player.should == game.players[2]
    game.current_turn = Turn.new(game.players[3])
    game.next_player.should == game.players.first
  end
  
end