require 'dominion/action/base/adventurer'
require 'dominion/action/base/bureaucrat'
require 'dominion/action/base/cellar'
require 'dominion/action/base/chancellor'
require 'dominion/action/base/chapel'
require 'dominion/action/base/council_room'
require 'dominion/action/base/feast'
require 'dominion/action/base/festival'
require 'dominion/action/base/laboratory'
require 'dominion/action/base/library'
require 'dominion/action/base/market'
require 'dominion/action/base/militia'
require 'dominion/action/base/mine'
require 'dominion/action/base/moat'
require 'dominion/action/base/moneylender'
require 'dominion/action/base/remodel'
require 'dominion/action/base/smithy'
require 'dominion/action/base/spy'
require 'dominion/action/base/thief'
require 'dominion/action/base/throne_room'
require 'dominion/action/base/village'
require 'dominion/action/base/witch'
require 'dominion/action/base/woodcutter'
require 'dominion/action/base/workshop'

module Dominion
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
    #                            B U R E A U C R A T                        #
    #########################################################################
    def bureaucrat_selection
      hand.victories.first 
    end
    
    module Human
      def bureaucrat_selection
        return nil if hand.victories.empty?
        select_card hand.victories, :message=>'Select a card to put on top of your deck', 
          :force=>true
      end
    end

    #########################################################################
    #                             C H A N C E L L O R                       #
    #########################################################################
    def use_chancellor?(turn)
      true 
    end
    
    module Human
      def use_chancellor?(turn)
        get_boolean 'Would you like discard your deck?'
      end
    end

    #########################################################################
    #                                   M O A T                             #
    #########################################################################
    # Return true to halt attack
    # Return false to continue
    def moat?
      !hand.moats.empty?
    end
    
    module Human
      def moat?
        return false if hand.moats.empty?
        get_boolean "Would you like to reveal a Moat?"
      end
    end

    #########################################################################
    #                                M I L I T I A                          #
    #########################################################################
    # Return discard list on successful attack
    # Return false on unsuccessful (Moat)
    def militia_discard
      return false if moat?
      hand[3..-1]
    end
    
    module Human
      def militia_discard
        return false if moat?
        discards = []
        while hand.size > 3
          discards << select_card(player.hand, :message=>"Choose a card to discard (from #{turn.player}'s Militia)", :force=>true)
        end
        return discards
      end
    end

    #########################################################################
    #                                   S P Y                               #
    #########################################################################
    # Return false to halt attack
    # Else return spied card
    def spy_on(player)
      return false if moat?
      player.reveal.first
    end

    # True to discard
    # False to put it back on top of deck
    def discard_from_spy?(card, player)
      !(card.is_a?(Victory) || card.is_a?(Curse))
    end
    
    module Human
      def discard_from_spy?(card, player)
        !get_boolean("Would you like to make #{player} discard #{card}? (Otherwise it goes back on top of their deck)")
      end
    end

    #########################################################################
    #                                  T H I E F                            #
    #########################################################################
    # Return false to halt attack
    def thief(player)
      return false if moat?
      revealed = player.reveal 2
      broadcast "#{player} revealed #{revealed.join ', '}"
      unless revealed.treasures.empty?
        card = revealed.treasures.first
        if card
          discard.unshift card
          broadcast "#{name} stole #{player}'s #{card}"
          revealed.delete card
        end
      end
      revealed.each{|c| player.discard.unshift c}
    end
    
    module Human
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

