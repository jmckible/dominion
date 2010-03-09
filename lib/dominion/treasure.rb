module Dominion
  class Treasure < Card
    def <=>(other)
      if other.is_a?(Action)
        1
      elsif other.is_a?(Treasure)
        value <=> other.value
      else
        -1
      end
    end
  end
end

