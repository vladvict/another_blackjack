module Blackjack
  class InitialBets
    def initialize(players)
      @players = players
    end
    
    def call
      init_message
      iterate_players
    end

    private

    def init_message
      puts "\n==================="
      puts Painter["Ok, let's make bets", :yellow]
      puts "===================\n\n"
    end

    def iterate_players
      @players.each do |player|
        puts Painter["#{player.name}\n", :blue]

        money = player.money
        puts "(current amount of money: #{money})"

        bet = Questioner.get_bet(money)
        hand = player.hands[0]
        
        player.make_bet(hand, bet)
        puts
      end
    end
  end
end




