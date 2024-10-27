class ChangeOrderEnumNames < ActiveRecord::Migration[7.2]
  def change
    remove_column :orders, :payment_status
    remove_column :orders, :status

    drop_enum :session_payment_status
    drop_enum :session_status

    create_enum :order_payment_status, [ "paid", "unpaid" ]
    create_enum :order_status, [ "open", "complete", "expired" ]

    add_column :orders, :payment_status, :order_payment_status, default: "unpaid", null: false
    add_column :orders, :status, :order_status, default: "open", null: false
  end
end
