module Blackjack
  class Game
    def initialize
      @dealer = Dealer.new
      @players = create_players
      @deck = Deck.new

      @finished = false
    end

    def play
      play_round until @finished
      puts Painter['Bye! Come back to recoup.', :yellow, :bg_black]
    end

    private

    def play_round
      initial_bets
      initial_deal
      
      player_decisions
      dealers_turn

      calculate_scores
      ask_to_continue
      
      check_players
    end

    def initial_bets
      InitialBets.new(@players).call
    end

    def initial_deal
      InitialDeal.new(@dealer, @players, @deck).call
    end

    def player_decisions
      PlayerDecisions.new(@dealer.hand, @players, @deck).call
    end

    def dealers_turn
      DealersTurn.new(@dealer.hand, @players, @deck).call
    end

    def calculate_scores
      CalculateScores.new(@dealer.hand, @players).call
    end

    def ask_to_continue
      @finished = AfterRoundAction.new(@dealer, @players, @deck).call
    end

    def check_players
      @players.delete_if { |player| player.money.zero? }
      
      @finished ||= true if @players.empty?
    end

    def create_players
      player_ids = Questioner.number_of_players

      @players = player_ids.inject([]) do |arr, id|
        arr << Player.new(id)
      end
    end
  end
end
