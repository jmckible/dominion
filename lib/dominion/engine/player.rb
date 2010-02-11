module Dominion
  module Engine
    class Player
      attr_accessor :seat, :name
    
      def initialize(name)
        self.name = name
      end
    end
  end
end