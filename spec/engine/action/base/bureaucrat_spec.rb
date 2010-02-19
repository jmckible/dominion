require 'spec_helper'

describe Bureaucrat do
  
  it 'should execute' do
    game, player, turn = GameFactory.build
    
    other = turn.other_players.first
    duchy = Duchy.new
    other.hand << duchy
    other.stub!(:bureaucrat_selection).and_return(duchy, nil, nil)
    
    turn.execute Bureaucrat.new
    
    player.deck.first.should be_is_a(Silver)
    other.deck.first.should == duchy
  end
  
end