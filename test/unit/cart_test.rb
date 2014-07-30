require 'test_helper'

class CartTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "should create a new line_item with an unique product" do
    cart = Cart.create
    cart.add_product(products(:one).id)
    cart.save!
    assert_equal 1, cart.line_items.count
    cart.add_product(products(:ruby).id)
    cart.save!
    assert_equal 2, cart.line_items.count
  end
  
  test "should no create a new line_item with a duplicate product" do
    cart = Cart.create
    cart.add_product(products(:one).id)
    cart.save!
    assert_equal 1, cart.line_items.count
    cart.add_product(products(:one).id)
    cart.save!
    assert_equal 1, cart.line_items.count
  end
end
