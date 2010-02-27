require 'dominion/engine/action/seaside/bazaar'
require 'dominion/engine/action/seaside/warehouse'

module Dominion
  module Engine
    module Seaside

      #########################################################################
      #                              K I N G D O M S                          #
      #########################################################################
      def self.available_kingdoms
        [ Bazaar, Warehouse ]
      end
      
      #########################################################################
      #                    P L A Y E R     D E C I S I O N S                  #
      #########################################################################
      def warehouse_discard
        hand.first(3).compact
      end
      
      module Human
        def warehouse_discard
          discards = []
          0.upto(2) do |i|
            card = select_card hand, :message=>'Choose a card to discard', :force=>true
            discards << card
          end
          discards.compact
        end
      end
      
    end
  end
end