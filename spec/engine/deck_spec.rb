require 'spec_helper'

describe Deck do
  it 'should setup and shuffle' do
    deck = Deck.new
    deck.setup
    deck.should have(10).cards
  end
end