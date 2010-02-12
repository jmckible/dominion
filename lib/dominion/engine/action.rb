module Dominion
  module Engine
    class Action < Card
      def self.starting_count() 10 end
      def play() end
    end
  end
end

require 'dominion/engine/action/base'