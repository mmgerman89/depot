class AddProductPriceInLineItem < ActiveRecord::Migration
  def self.up
    add_column :line_items, :price, :decimal, precision: 8, scale: 2
    
    say_with_time "Updating prices..." do
      LineItem.find(:all).each do |lineitem|
        lineitem.update_attribute :price, Product.find(lineitem.product_id).price#lineitem.product.price
      end
    end
  end

  def self.down
    remove_column :line_items, :price
  end
end
