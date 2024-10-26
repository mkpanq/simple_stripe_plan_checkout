class BundleRepository
  def get_all
    Bundle.all
  end

  def get_active
    Bundle.where(active: true).sort_by(&:price)
  end

  def save_to_db(bundles)
    Bundle.upsert_all(bundles, unique_by: :bundle_id)
  end
end
