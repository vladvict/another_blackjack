module Blackjack
  class InitialDeal
    def initialize(dealer, players, deck)
      @dealer = dealer
      @players = players
      @deck = deck
    end

    def call
      init_message
      deal_for_players
      deal_for_dealer
    end

    private
    
    def init_message
      puts "\n=============="
      puts Painter["Dealing cards:", :yellow]
      puts "==============\n\n"
    end

    def deal_for_players
      @players.each do |player|
        puts Painter["#{player.name}\n", :blue]

        hand = player.hands[0]

        2.times do
          card = @deck.pull_one_card
          hand.update_score(card)
        end

        hand.show_stats
        puts '------------------'

        sleep 1
      end
    end

    def deal_for_dealer
      puts Painter["Dealer's hand", :cyan]

      dealers_hand = @dealer.hand
      card = @deck.pull_one_card
      dealers_hand.update_score(card, handler: :dealer)

      dealers_hand.show_stats

      sleep 1
    end
  end
end



