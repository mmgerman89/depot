class AddPaymentTypeIdToOrder < ActiveRecord::Migration
  def self.up
    create_table :payment_types do |t|
      t.string :name

      t.timestamps
    end
    
    add_column :orders, :payment_type_id, :integer
    Order.reset_column_information
    Order.all.each do |order|
      order.payment_type_id = case order.pay_type
                                when 'Check'
                                  1
                                when 'Credit Card'
                                  2
                                when 'Purchase order'
                                  3
                                end
      order.save validate: false
    end
    remove_column :orders, :pay_type
  end

  def self.down
    add_column :orders, :pay_type, :string
    Order.reset_column_information
    Order.all.each do |order|
      order.pay_type = case order.payment_type_id
                       when 1
                         'Check'
                       when 2
                         'Credit Card'
                       when 3
                         'Purchase order'
                       else
                         'Credit Card'
                       end
      order.payment_type_id = 0
      order.save validate: false
    end
    Order.reset_column_information
    drop_table :payment_types
    remove_column :orders, :payment_type_id
  end
end
