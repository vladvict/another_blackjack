require_relative '../test_helper.rb'

class TestDeck < Minitest::Test
  def setup
    @deck = Blackjack::Deck.new
  end

  def test_initialize
    cards = @deck.cards
    assert(cards.size > 0)
  end
  
  def test_pull_one_card
    deck_size = @deck.cards.size

    @deck.pull_one_card

    assert_equal(deck_size - 1, @deck.cards.size)
  end
  
  def test_fresh_cards
    old_cards = @deck.cards
    @deck.pull_one_card
    old_deck_size = @deck.cards.size

    @deck.fresh_cards

    refute_equal(old_cards, @deck.cards)
    assert(@deck.cards.size > old_deck_size)
  end
end
