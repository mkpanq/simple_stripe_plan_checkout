class CreateBundles < ActiveRecord::Migration[7.2]
  create_enum :recurring_interval_enum, [ "monthly", "yearly", "quarterly" ]

  def change
    create_table :bundles do |t|
      t.boolean :active, null: false, default: true
      t.string  :bundle_id, null: false
      t.string  :name, null: false
      t.string  :description
      t.enum    :recurring_type, enum_type: "recurring_interval_enum", null: false, default: "monthly"
      t.integer :price, null: false
      t.string  :currency, null: false

      t.timestamps
    end
  end
end
