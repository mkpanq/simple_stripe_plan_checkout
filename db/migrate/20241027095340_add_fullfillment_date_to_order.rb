class AddFullfillmentDateToOrder < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :fulfillment_date, :datetime
  end
end
