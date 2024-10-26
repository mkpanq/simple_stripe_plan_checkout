class BundleIdHaveToBeUnique < ActiveRecord::Migration[7.2]
  def change
    add_index :bundles, :bundle_id, unique: true
  end
end
