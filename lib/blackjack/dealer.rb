module Blackjack
  class Dealer
    attr_reader :hand

    def initialize
      refresh_hand
    end

    def refresh_hand
      @hand = Hand.new
    end
  end
end
