require 'spec_helper'

describe Turn do
  
  it 'should know other players' do
    game = GameFactory.build
    turn = Turn.new game, game.players.first
    turn.other_players.should == [game.players[1], game.players[2], game.players[3]]
  end
  
  it 'should count treasure' do
    game = Game.new
    player = Player.new 'Player'
    player.hand << Copper.new
    player.hand << Copper.new
    turn = Turn.new game, player
    turn.play_treasure
    turn.treasure.should == 2
    turn.in_play.size.should == 2
    player.hand.should be_empty
  end
  
  it 'should discard' do
    game = GameFactory.build
    player = game.players.next
    turn = Turn.new game, player
    card = player.hand.first
    turn.discard card
    player.discard.should == [card]
    player.hand.size.should == 4
  end
  
end