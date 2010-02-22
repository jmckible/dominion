require 'dominion/engine/action/base/adventurer'
require 'dominion/engine/action/base/bureaucrat'
require 'dominion/engine/action/base/cellar'
require 'dominion/engine/action/base/chancellor'
require 'dominion/engine/action/base/chapel'
require 'dominion/engine/action/base/council_room'
require 'dominion/engine/action/base/feast'
require 'dominion/engine/action/base/festival'
require 'dominion/engine/action/base/laboratory'
require 'dominion/engine/action/base/library'
require 'dominion/engine/action/base/market'
require 'dominion/engine/action/base/militia'
require 'dominion/engine/action/base/mine'
require 'dominion/engine/action/base/moat'
require 'dominion/engine/action/base/moneylender'
require 'dominion/engine/action/base/remodel'
require 'dominion/engine/action/base/smithy'
require 'dominion/engine/action/base/spy'
require 'dominion/engine/action/base/thief'
require 'dominion/engine/action/base/throne_room'
require 'dominion/engine/action/base/village'
require 'dominion/engine/action/base/witch'
require 'dominion/engine/action/base/woodcutter'
require 'dominion/engine/action/base/workshop'

module Dominion
  module Engine
    module Base
      
      #########################################################################
      #                              K I N G D O M S                          #
      #########################################################################
      def self.available_kingdoms
        [ Adventurer, Bureaucrat, Cellar, Chancellor, Chapel, CouncilRoom, 
          Feast, Festival, Gardens, Laboratory, Library, Market, Militia, Mine, 
          Moat, Moneylender, Remodel, Smithy, Spy, Thief, ThroneRoom, Village, 
          Witch, Woodcutter, Workshop ]
      end
      
      #########################################################################
      #                    P L A Y E R     D E C I S I O N S                  #
      #########################################################################
      def bureaucrat_selection
        return nil if hand.victories.empty?
        return hand.victories.first unless socket # AI player
        select_card hand.victories, :message=>'Select a card to put on top of your deck', 
          :force=>true
      end

      def use_chancellor?(turn)
        return true unless socket # AI player
        get_boolean 'Would you like discard your deck?'
      end

      #########################################################################
      #                             A T T A C K S                             #
      #########################################################################

      # Return true to halt attack
      # Return false to continue
      def moat?
        return false if hand.moats.empty?
        if socket
          get_boolean "Would you like to reveal a Moat?"
        else # AI
          true
        end
      end

      # Return discard list on successful attack
      # Return false on unsuccessful (Moat)
      def militia_discard
        return false if moat?
        if socket
          discards = []
          while hand.size > 3
            discards << select_card(player.hand, 
              :message=>"Choose a card to discard (from #{turn.player}'s Militia)",
              :force=>true)
          end
        else # AI Player
          discards = hand[3..-1]
        end
        return discards
      end

      # Return false to halt attack
      # Else return spied card
      def spy_on(player)
        return false if moat?
        player.reveal.first
      end

      # True to discard
      # False to put it back on top of deck
      def discard_from_spy?(card, player)
        if socket
          get_boolean "Would you like to make #{player} discard #{card}? (Otherwise it goes back on top of their deck)"
        else # AI
          !(card.is_a?(Victory) || card.is_a?(Curse))
        end
      end

      # Return false to halt attack
      def thief(player)
        return false if moat?
        revealed = player.reveal 2
        broadcast "#{player} revealed #{revealed.join ', '}"
        unless revealed.treasures.empty?
          card = select_card revealed.treasures, :message=>"Choose a treasure to trash"
          if card
            if get_boolean("Would you like to steal #{card}?")
              discard.unshift card
              broadcast "#{name} stole #{player}'s #{card}"
            else
              game.trash.unshift card
              broadcast "#{name} trashed #{player}'s #{card}"
            end
            revealed.delete card
          end
        end
        revealed.each{|c| player.discard.unshift c}
      end
      
    end
  end
end

