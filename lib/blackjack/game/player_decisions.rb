module Blackjack
  class PlayerDecisions
    def initialize(dealers_hand, players, deck)
      @dealers_hand = dealers_hand
      @players = players
      @deck = deck
    end
    
    def call
      init_message
      iterate_players
    end

    private

    def init_message
      puts "\n=============="
      puts Paint["Player's turn:", :yellow]
      puts "==============\n\n"
    end

    def iterate_players
      @players.each do |player|
        players_name = "=== Turn of #{player.name} ===\n"
        puts Paint[players_name, :blue]

        can_split = ConditionCheck.can_split?(player)

        # first hand iteration
        first_hand = player.hands[0]
        splitted = play_one_hand(player, first_hand, can_split, nil)

        # iterate through each hand if split
        if splitted
          can_split = false
          
          player.hands.each_with_index do |hand, index|
            play_one_hand(player, hand, can_split, index)
          end
        end
      end
    end

    def play_one_hand(player, hand, can_split, hand_index)
      splitted = false

      loop do
        show_players_hand(hand, hand_index)

        break if got_blackjack?(hand)
        break if got_busted?(hand)

        action = Questioner.action_descision(player.money, can_split)
        
        case action
        when :split
          if can_split
            puts "splitting.."
            sleep 1

            player.split_hand(@deck)
            splitted = true
            break
          end
        when :stand
          print_when_stand
          break
        when :surrender
          surrender(hand)
          break
        when :double
          double_value = Questioner.double_down_value(hand.bet, player.money)
          player.make_bet(hand, double_value)
          draw_new_card(hand)

          break if got_blackjack?(hand)
          break if got_busted?(hand)
          break
        when :hit
          draw_new_card(hand)
          can_split = false

          break if got_full_hand?(hand)
          break if got_busted?(hand)
        end
      end

      puts
      splitted
    end

    def surrender(hand)
      hand.status = :surrender
      
      puts 'You passed this turn.'
      sleep 1
    end

    def print_when_stand
      puts 'Moving on with "stand".'
      sleep 1
    end

    def got_blackjack?(hand)
      blackjack = ConditionCheck.blackjack?(hand)

      if blackjack
        puts "Your score is #{hand.score} in this hand."
        puts "You've got BLACKJACK!\n\n"
        hand.status = :blackjack

        sleep 1
        true
      end
    end

    def got_busted?(hand)
      busted = ConditionCheck.busted?(hand)

      if busted
        puts "You've got BUSTED with score: #{hand.score}.\n\n"
        hand.status = :busted

        sleep 1
        true
      end
    end

    def got_full_hand?(hand)
      stop_value = Constants::BLACKJACK_VALUE
      full_hand = hand.score == stop_value

      if full_hand
        puts "Your score is #{hand.score} in this hand."
        puts 'Moving on.'

        sleep 1
        true
      end
    end

    def draw_new_card(hand)
      puts "Drawing new card..\n\n"
      sleep 1

      new_card = @deck.pull_one_card
      puts "New card is: #{new_card}"

      hand.update_score(new_card)
      puts "Your score is: #{hand.score}\n\n"

      sleep 1
    end

    def show_players_hand(hand, hand_index)
      hand_index += 1 if hand_index

      puts '------------'
      puts Paint["Your hand #{hand_index}:", :white, :bright]
      hand.show_stats
    end
  end
end
