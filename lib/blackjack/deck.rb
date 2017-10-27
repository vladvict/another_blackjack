module Blackjack
  class Deck
    SUITS = ['♦', '♣', '♠', '♥']
    VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A']

    attr_reader :cards

    def initialize
      @cards = fresh_cards
    end

    def pull_one_card
      card = @cards.sample
      @cards.delete(card)
    end
    
    def fresh_cards
      cards = []

      SUITS.each do |suit|
        suit_pack = VALUES.map { |val| [val, suit] }
        cards += suit_pack
      end

      @cards = cards.shuffle
    end
  end

end
