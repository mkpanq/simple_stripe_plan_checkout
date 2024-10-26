class BundleRepository
  def get_all
    Bundle.all
  end

  def get_active
    Bundle.where(active: true)
  end
end
