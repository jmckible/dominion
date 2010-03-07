require 'spec_helper'

###############################################################################
#                                  I  /  O                                    #
###############################################################################                 
describe Player, 'IO' do
  it 'should select a card' do
    player = Dominion::Terminal::Player.new 'player', nil
    player.stub!(:say_card_list).and_return(true)
    
    copper, silver, gold = Copper.new, Silver.new, Gold.new
    cards = [copper, silver, gold]
    
    player.stub!(:ask).and_return("1\n")
    player.select_card(cards).should == copper
    
    player.stub!(:ask).and_return("3\n")
    player.select_card(cards).should == gold
    
    player.stub!(:ask).and_return("0\n")
    player.select_card(cards).should be_nil
    
    player.stub!(:ask).and_return("4\n", "-1\n", "2\n")
    player.select_card(cards).should == silver
  end
end