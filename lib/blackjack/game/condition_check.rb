module Blackjack
  module ConditionCheck
    extend self

    def blackjack?(hand)
      true if hand.cards.size == 2 && hand.score == Constants::BLACKJACK_VALUE
    end

    def busted?(hand)
      true if hand.score > Constants::BLACKJACK_VALUE
    end
  
    def can_split?(player)
      hand = player.hands[0]
      cards = hand.cards
      
      not_enough_money = player.money < hand.bet
      return if not_enough_money || cards.size != 2

      return true if cards[0][0] == cards[1][0]

      first_face = Constants::FACES.include?(cards[0][0])
      second_face = Constants::FACES.include?(cards[1][0])
      return true if first_face && second_face
    end
  end
end
