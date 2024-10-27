class CreateOrders < ActiveRecord::Migration[7.2]
  create_enum :session_payment_status, [ "no_payment_required", "paid", "unpaid" ]
  create_enum :session_status, [ "open", "complete", "expired" ]

  def change
    create_table :orders do |t|
      t.string :payment_session_id, null: false, index: { unique: true }
      t.enum :payment_status, enum_type: "session_payment_status", null: false, default: "unpaid"
      t.enum :status, enum_type: "session_status", null: false, default: "open"

      t.timestamps
    end
  end
end
