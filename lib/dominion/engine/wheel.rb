module Dominion
  module Engine
    class Wheel < Array
      
      attr_accessor :index, :count
      
      def start
        @index = 0
        @count = 0
      end
      alias :restart :start
      
      def next
        element = at(index)
        @index = index + 1
        restart if @index > (size - 1)
        @count = count + 1
        return element
      end
      
      def turn()  count end
      def round() count % size end
      
    end
  end
end