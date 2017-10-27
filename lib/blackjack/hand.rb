module Blackjack
  class Hand
    attr_reader :cards, :score, :bet
    attr_accessor :status

    def initialize
      clear_cards_and_score
      @bet = 0
    end

    def make_bet(value)
      @bet += value
    end

    def update_score(card, handler: :player)
      value = card[0]

      case
      when value == Constants::ACE
        if handler == :dealer
          @score += with_high_ace
        else
          current_score = @score
          @score += Questioner.player_ace_value(current_score)
        end
      when Constants::FACES.include?(value)
        @score += Constants::FACE_VALUE
      else
        @score += value.to_i
      end

      @cards << card
      @score
    end

    def split!
      cards = @cards.dup
      clear_cards_and_score

      update_score(cards[0])
      cards[1]
    end

    def show_stats
      puts
      print_cards
      print_score
      print_bet unless @bet.zero?
      print_status if @status
      puts
    end
    
    private

    def clear_cards_and_score
      @cards = []
      @score = 0
    end

    def with_high_ace
      ace_values = Constants::ACE_VALUES
      high_score = @score + ace_values[1]

      if high_score > Constants::BLACKJACK_VALUE
        ace_values[0]
      else
        ace_values[1]
      end
    end

    def print_cards
      if @cards.empty?
        puts 'Cards: --'
      else
        puts 'Cards:'
        puts cards.inject('') { |str, card| str + "#{card}\n" }
      end
    end

    def print_score
      puts "Score: #{@score}"
    end

    def print_bet
      puts "Current bet: #{@bet}"
    end

    def print_status
      puts "Status: #{@status}"
    end
  end
end
