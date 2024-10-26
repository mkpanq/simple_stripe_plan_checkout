class DashboardService
  # TODO: Should we do it more generative ?
  def initialize
    @bundle_repository = BundleRepository.new
    # Here we'll have payment service choice
  end

  def get_dashboard_data
    {
      active_bundles: get_active_bundles
    }
  end

  private

  def get_active_bundles
    @bundle_repository.get_active
  end
end
