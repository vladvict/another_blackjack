require_relative '../test_helper.rb'

class TestPlayer < Minitest::Test
  def setup
    @player = Blackjack::Player.new(1)
  end

  def test_initialize
    default_money = Blackjack::Constants::MONEY_AT_START

    assert(@player.money == default_money)
    assert_match(/Player/, @player.name)
  end

  def test_make_bet
    money = @player.money
    bet = 50
    expected_amount = money - bet

    @player.make_bet(@player.hands[0], bet)

    assert_equal(expected_amount, @player.money)
  end

  def test_add_prize
    money = @player.money
    prize = 100
    expected_amount = money + prize

    @player.add_prize(prize)

    assert_equal(expected_amount, @player.money)
  end

  def test_surrender
    bet = 100
    hand = @player.hands[0]
    @player.make_bet(hand, bet)
    money_after_bet = @player.money

    @player.surrender(hand)

    assert(@player.money > money_after_bet)
  end
  
  def test_split_hand
    deck = Blackjack::Deck.new
    deck = with_removed_aces(deck)
    2.times do
      @player.hands[0].update_score(deck.pull_one_card)
    end
    initial_hands_size = @player.hands.size

    @player.split_hand(deck)
    
    assert(@player.hands.size > initial_hands_size)
  end
  
  def test_refresh_hands
    old_hand = @player.hands[0]

    @player.refresh_hands

    refute_equal(old_hand, @player.hands[0])
  end

  private

  def with_removed_aces(deck)
    cards = deck.cards.dup
    cards.delete_if { |x| x[0] == 'A' }

    deck.instance_variable_set(:@cards, cards)
    deck
  end
end
