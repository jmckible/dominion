# Keeps track of whose turn it is

module Dominion
  class Wheel < Array
    
    attr_accessor :index
    
    def choose_starting
      @index = rand size
    end

    def next
      player = at index
      @index = index + 1
      @index = 0 if @index > (size - 1)
      return player
    end
    
  end
end