module Blackjack
  class AfterRoundAction
    def initialize(dealer, players, deck)
      @dealer = dealer
      @players = players
      @deck = deck

      @continue = false
    end
    
    def call
      ask_to_continue
      prepare_next_round
      finished_status
    end

    private

    def prepare_next_round
      return unless @continue

      @dealer.refresh_hand
      @players.each { |player| player.refresh_hands }
      @deck.fresh_cards
    end

    def finished_status
      @continue ? false : true
    end

    def ask_to_continue
      puts "===========================\n\n"
      counter = 0

      loop do
        abort if counter >= 3

        message = 'Want to play another round?'
        puts Paint[message, :white, :black]
        
        puts 'y (yes) or n (no)'
        choice = gets.chomp.downcase
        
        unless ['y', 'yes', 'n', 'no'].include?(choice)
          counter += 1
          next
        end

        if choice == 'y' || choice == 'yes'
          @continue = true
        end

        break
      end
    end
  end
end