module Dominion
  module Engine
    class Wheel < Array
      
      attr_accessor :index
      
      def start
        @index = 0
      end
      alias :restart :start
      
      def next
        element = at(index)
        @index = index + 1
        restart if @index > (size - 1)
        return element
      end
      
    end
  end
end