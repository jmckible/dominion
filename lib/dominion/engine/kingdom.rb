module Dominion
  module Engine
    class Kingdom < Card
      def self.starting_count() 10 end
    end
  end
end

require 'dominion/engine/kingdom/base'