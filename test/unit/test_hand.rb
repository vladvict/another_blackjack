require_relative '../test_helper.rb'

class TestHand < Minitest::Test
  def setup
    @hand = Blackjack::Hand.new
  end
  
  def test_make_bet
    init_bet = @hand.bet
    value = 100

    @hand.make_bet(value)

    assert_equal(init_bet + value, @hand.bet)
  end
  
  def test_update_score
    old_score = @hand.score
    value = 2
    card = [value, 'test']

    @hand.update_score(card)

    assert_equal(old_score + value, @hand.score)
  end

  def test_split
    2.times do
      @hand.update_score([2,'test'])
    end
    old_cards_size = @hand.cards.size
    
    @hand.split!

    assert(old_cards_size > @hand.cards.size)
  end
end