require_relative '../test_helper.rb'

class TestDealer < Minitest::Test
  def test_initialize
    dealer = Blackjack::Dealer.new
    dealers_hand = dealer.hand

    refute_nil(dealers_hand)
    assert_instance_of(Blackjack::Hand, dealers_hand)
  end
end
