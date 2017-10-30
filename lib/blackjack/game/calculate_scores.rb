module Blackjack
  class CalculateScores
    def initialize(dealers_hand, players)
      @dealers_status = dealers_hand.status
      @dealers_score = dealers_hand.score
      @players = players
      @result = []
    end

    def call
      init_message
      calculate_scores
    end
    
    private

    def init_message
      puts "\n=============="
      puts Paint["Round results:", :yellow]
      puts "==============\n\n"
    end

    def calculate_scores
      @players.each do |player|
        players_name = "=== #{player.name} ===\n"
        puts Paint[players_name, :blue]

        hands_size = player.hands.size

        player.hands.each_with_index do |hand, hand_index|
          show_hand(hand.score, hand_index, hands_size)

          if @dealers_status == :busted
            process_dealer_busted(player, hand)
          elsif hand.status
            case hand.status
            when :blackjack
              process_blackjack(player, hand)
            when :busted
              process_busted(hand)
            when :surrender
              process_surrender(player, hand)
            end
          else
            compare_scores(player, hand)
          end

          puts "\n\n"
          sleep 0.5
        end

        bankrupt_check(player)
      end
    end

    def compare_scores(player, hand)
      case
      when @dealers_status == :blackjack
        puts 'Dealer has BLACKJACK'
        puts "and you don't.\n\n"
        puts "You lose this bet."
      when @dealers_score == hand.score
        puts "Standoff."
        puts "Dealer has the same score as you (#{hand.score})"

        player.add_prize(hand.bet)
        puts "Your prize: #{hand.bet} (your bet)."
      when @dealers_score > hand.score
        puts "Dealer has more score points than you."
        puts "(#{@dealers_score} to #{hand.score})"

        puts "You lose this bet."
      when @dealers_score < hand.score
        puts "You have more score points than Dealer."
        puts "(#{hand.score} to #{@dealers_score})"

        prize = full_prize(hand.bet)
        player.add_prize(prize)

        puts "Your prize: #{prize}."
      end
    end

    def process_surrender(player, hand)
      puts 'You "surrendered" this hand.'

      prize = half_prize(hand.bet)
      player.add_prize(prize)

      puts "Your prize: #{prize} (half of the bet)."
    end

    def process_busted(hand)
      puts "Your hand's got BUSTED."
      puts "You lose this bet (#{hand.bet})."
    end

    def process_blackjack(player, hand)
      puts "You've got BLACKJACK!"

      if @dealers_status == :blackjack
        puts "Dealer has too. It's even.\n\n"

        player.add_prize(hand.bet)
        puts "Your prize: #{hand.bet} (your bet)."
      else
        prize = full_prize(hand.bet)
        player.add_prize(prize)

        puts 'Well played!'
        puts "Your prize: #{prize}."
      end
    end

    def process_dealer_busted(player, hand)
      if hand.status == :busted
        process_busted(hand)
      else
        prize = full_prize(hand.bet)
        player.add_prize(prize)

        puts 'Dealer is BUSTED!'
        puts "Your prize: #{prize}."
      end
    end

    def half_prize(hand_bet)
      hand_bet / 2
    end

    def full_prize(hand_bet)
      (hand_bet * 1.5).to_i
    end

    def show_hand(hand_score, hand_index, hands_size)
      index = hands_size > 1 ? hand_index + 1 : nil

      puts Paint["Hand #{index}", :white, :bright]
      puts "Score: #{hand_score}\n\n"
    end

    def bankrupt_check(player)
      puts "You're out of funds." if player.money <= 0
    end
  end
end
