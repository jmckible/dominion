require 'spec_helper'

###############################################################################
#                                  I  /  O                                    #
###############################################################################                 
describe Human, 'IO' do
  it 'should select a card' do
    game = Game.new
    human = Human.new 'Human', nil
    human.stub!(:say_card_list).and_return(true)
    
    copper, silver, gold = Copper.new, Silver.new, Gold.new
    cards = [copper, silver, gold]
    
    human.stub!(:ask).and_return("1\n")
    human.select_card(cards).should == copper
    
    human.stub!(:ask).and_return("3\n")
    human.select_card(cards).should == gold
    
    human.stub!(:ask).and_return("0\n")
    human.select_card(cards).should be_nil
    
    human.stub!(:ask).and_return("4\n", "-1\n", "2\n")
    human.select_card(cards).should == silver
  end
end