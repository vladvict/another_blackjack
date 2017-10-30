module Blackjack
  class DealersTurn
    def initialize(hand, players, deck)
      @hand = hand
      @players = players
      @deck = deck
    end

    def call
      init_message
      draw_cards
    end

    private
    
    def init_message
      puts "\n=============="
      puts Paint["Dealer's turn:", :yellow]
      puts "==============\n\n"
    end

    def draw_cards
      return skip_message if all_hands_are_busted?

      loop do
        show_hand
        draw_card

        break if blackjack?
        break if stand?
      end

      last_message = "Dealer's score is: #{@hand.score}\n\n"
      puts Paint[last_message, :white, :bright]
    end

    def draw_card
      puts "Drawing card..\n\n"
      sleep 0.5

      new_card = @deck.pull_one_card
      @hand.update_score(new_card, handler: :dealer)
      puts "The card is: #{new_card}\n\n"

      sleep 1.5
    end

    def blackjack?
      if @hand.cards.size == 2 && @hand.score == Constants::BLACKJACK_VALUE
        puts "Dealer has BLACKJACK!"
        @hand.status = :blackjack

        true
      end
    end

    def stand?
      score = @hand.score
      
      if score >= Constants::DEALER_STAND_VALUE
        @hand.status = :busted if score > Constants::BLACKJACK_VALUE
        true
      end
    end

    def show_hand
      puts '-----'
      puts Paint['Hand:', :white, :bright]
      @hand.show_stats
    end

    def skip_message
      message = "Every players's hands are BUSTED\n\n"
      puts Paint[message, :white, :bright]
    end

    def all_hands_are_busted?
      hands = @players.map { |player| player.hands }.flatten
      hands.all? { |hand| hand.status == :busted } 
    end
  end
end
