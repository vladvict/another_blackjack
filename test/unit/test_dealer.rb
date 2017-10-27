require_relative '../helper.rb'

class TestDealer < Test::Unit::TestCase
  def test_initialize
    dealer = Blackjack::Dealer.new
    dealers_hand = dealer.hand

    assert_not_nil(dealers_hand)
    assert_instance_of(Blackjack::Hand, dealers_hand)
  end
end
