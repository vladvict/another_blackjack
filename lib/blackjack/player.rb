module Blackjack
  class Player
    attr_reader :name, :hands, :money

    def initialize(id)
      @name = "Player #{id}"
      @money = Constants::MONEY_AT_START
      refresh_hands
    end
    
    def make_bet(hand, bet)
      return if bet > @money

      @money -= bet
      hand.make_bet(bet)
    end

    def add_prize(amount)
      @money += amount
    end

    def surrender(hand)
      regain = hand.bet / 2
      @money += regain
    end
    
    def split_hand(deck)
      return if @hands.size > 1
      
      old_hand = hands[0]
      second_card = old_hand.split!

      new_hand = Hand.new
      new_hand.update_score(second_card)
      make_bet(new_hand, old_hand.bet)
      @hands << new_hand

      [old_hand, new_hand].each do |hand|
        hand.update_score(deck.pull_one_card)
      end
    end

    def refresh_hands
      @hands = [Hand.new]
    end
  end
end
  