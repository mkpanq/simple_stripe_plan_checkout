class BundleRepository
  def get_all
    Bundle.all
  end

  def find(id)
    Bundle.find(id)
  end

  def find_by_bundle_id(bundle_id)
    Bundle.find_by(bundle_id: bundle_id)
  end

  def get_active
    Bundle.where(active: true).sort_by(&:price)
  end

  def save_to_db(bundles)
    Bundle.upsert_all(bundles, unique_by: :bundle_id)
  end
end
