module Dominion
  class Action < Card
    def <=>(other)
      if other.is_a? Action
        to_s <=> other.to_s
      else
        -1
      end
    end
  end
end