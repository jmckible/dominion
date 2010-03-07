require 'spec_helper' 

describe BigMoney do
  before(:all) do
    @big_money = BigMoney.new 'Big Money'
  end

  it 'should buy a province if available' do
    province = Province.new
    @big_money.select_buy([province, Gold.new, Smithy.new]).should == province
  end
  
  it 'should buy a gold if available' do
    gold = Gold.new
    @big_money.select_buy([gold, Smithy.new, Copper.new]).should == gold
  end
  
  it 'should buy a silver if available' do
    silver = Silver.new
    @big_money.select_buy([Estate.new, Duchy.new, Smithy.new, silver]).should == silver
  end
  
  it 'should buy a copper if all else fails' do
    copper = Copper.new
    @big_money.select_buy([Village.new, Smithy.new, Cellar.new, copper]).should == copper
  end
  
end