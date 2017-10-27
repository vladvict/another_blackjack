module Blackjack
  module Constants
    MONEY_AT_START = 500
    MAX_PLAYERS = 3

    DILLER_STAND_VALUE = 17
    BLACKJACK_VALUE = 21

    FACES = ['J', 'Q', 'K']
    FACE_VALUE = 10
    ACE = 'A'
    ACE_VALUES = [1, 11]

    ACTIONS_HELP = [
      'You can choose from next actions by typing:',
      ' "h"     - for "hit"         (take another card from the dealer);',
      ' "s"     - for "stand"       (take no more cards and wait for results);',
      ' "d"     - for "double down" (increase the initial bet by up to 100% and',
      '                              commit "stand" after receiving next card);',
      ' "surr"  - for "surrender"   (stop playing this round and get half',
      '                              of your bet in return);',
      ' "split" - for "split"       (only once, in right conditions and if it is',
      '                              enough money you can split your hand',
      '                              in two and play/bet both);',
      ''
    ]

    def self.action_help
      puts ACTIONS_HELP
    end
  end
end
