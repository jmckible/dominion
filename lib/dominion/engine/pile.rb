module Dominion
  module Engine
    class Pile < Array
      
      attr_accessor :card_type
      
      def initialize(card_type=nil, number=nil)
        @card_type = card_type if card_type
        1.upto(number){self << card_type.new } if card_type && number
      end
      
      def discard(number)
        1.upto(number){pop}
      end
      
      def actions
        select{|card| card.is_a? Action}
      end
      
      def treasures
        select{|card| card.is_a? Treasure }
      end
      
      def victories
        select{|card| card.is_a? Victory }
      end
      
      def to_s
        collect.join ', '
      end
      
    end
  end
end