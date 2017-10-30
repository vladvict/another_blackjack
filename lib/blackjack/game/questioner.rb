module Blackjack
  module Questioner
    extend self

    def get_bet(money)
      bet_message = "You can bet from 1 to #{money}:"
      puts Painter[bet_message, :white, :bg_black]
      bet = 0

      loop do
        value = gets.chomp.to_i

        if (1..money) === value 
          bet = value
          break
        else
          retry_message = "Choose valid bet (between 1 and #{money}):"
          puts Painter[retry_message, :white, :bg_black]
        end
      end

      bet
    end

    def player_ace_value(hand_score)
      ace_values = "(#{Constants::ACE_VALUES[0]} or #{Constants::ACE_VALUES[1]} )"
      puts Painter["You have 'ace'. Choose value #{ace_values}:", :white, :bg_black]
      puts "(your current score: #{hand_score})\n"

      chosen_value = 0

      loop do
        value = gets.chomp.to_i

        if Constants::ACE_VALUES.include?(value)
          chosen_value = value
          break
        else
          puts Painter["Choose valid 'ace' value #{ace_values}:", :white, :bg_black]

        end
      end

      chosen_value
    end

    def number_of_players
      max_players = Constants::MAX_PLAYERS
      message = "How many players will take part? (from 1 to #{max_players}) \n"
      puts Painter[message, :white, :bg_black]

      range = (1..max_players)
      counter = 0
      number = nil
      
      loop do
        if counter >= 5
          puts Painter['Next time..', :yellow, :bg_black]

          abort
        end

        choice = gets.chomp.to_i

        if range === choice
          number = choice
          break
        else
          counter += 1
          repeat_message = "Please type the number between 1 and #{max_players}: \n"
          puts Painter[repeat_message, :white, :bg_black]
        end

      end

      (1..number).to_a
    end

    def double_down_value(hand_bet, money)
      allowed = hand_bet > money ? money : hand_bet
      allowed_range = (1..allowed)
      value = 0

      loop do
        message = "Choose additional bet (from 1 to #{allowed}):"
        puts Painter[message, :white, :bg_black]

        choice = gets.chomp.to_i

        if allowed_range === choice
          value = choice
          break
        end
      end

      value
    end

    def action_descision(player_money, can_split = nil)
      no_money = player_money.zero?

      options = {
        'h'    => :hit,
        's'    => :stand,
        'd'    => :double,
        'surr' => :surrender
      }

      action = nil

      loop do
        puts_action_options(can_split)
        choice = gets.chomp

        if can_split && choice == 'split'
          action = :split
          break
        end

        if options.has_key?(choice)
          if choice == 'd' && no_money
            puts 'Sorry, no money for double down.'
          else
            action = options[choice]
            break
          end
        end

        Constants.action_help if choice == 'help'
      end

      action
    end

    private

    def puts_action_options(can_split)
      puts '-----------------------------------------'
      puts ' h - for "hit"           s - for "stand"'
      puts ' d - for "double down"   surr - for "surrender"'
      puts ' split - for "split" hand' if can_split
      puts " help - for more detailed description on available moves\n\n"
      puts Painter['Choose your next move:', :white, :bg_black]
    end
  end
end
