module Dominion
  module Engine
    class Player
      attr_accessor :name
    
      def initialize(name='')
        self.name = name
      end
    end
  end
end