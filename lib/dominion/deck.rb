module Dominion
  class Deck < Array
    def shuffle
      sort_by{rand}
    end
  end
end