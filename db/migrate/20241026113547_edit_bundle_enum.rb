class EditBundleEnum < ActiveRecord::Migration[7.2]
  def change
    remove_column :bundles, :recurring_type
    drop_enum :recurring_interval_enum
    create_enum :recurring_interval_enum, %w[day month week year]
    add_column :bundles, :recurring_type, :recurring_interval_enum, default: "month", null: false
  end
end
