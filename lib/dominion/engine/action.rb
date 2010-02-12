module Dominion
  module Engine
    class Action < Card
      def self.starting_count() 10 end
    end
  end
end

require 'dominion/engine/action/base'