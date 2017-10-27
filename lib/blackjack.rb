$LOAD_PATH.unshift File.dirname(__FILE__)
require 'blackjack/game'
require 'blackjack/hand'
require 'blackjack/deck'
require 'blackjack/dealer'
require 'blackjack/player'
require 'blackjack/constants'
require 'blackjack/game/questioner'
require 'blackjack/game/initial_bets'
require 'blackjack/game/initial_deal'
require 'blackjack/game/dealers_turn'
require 'blackjack/game/condition_check'
require 'blackjack/game/player_decisions'
require 'blackjack/game/calculate_scores'
require 'blackjack/game/after_round_action'

require 'paint'

module Blackjack
  def self.play
    puts Paint["=== BLACKJACK ===\n\n", :yellow]

    sleep 0.5

    game = Game.new
    game.play
  end
end
