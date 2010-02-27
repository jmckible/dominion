require 'dominion/action/seaside/bazaar'
require 'dominion/action/seaside/warehouse'

module Dominion
  module Seaside
    def self.available_kingdoms
      [ Bazaar, Warehouse ]
    end    
  end
end