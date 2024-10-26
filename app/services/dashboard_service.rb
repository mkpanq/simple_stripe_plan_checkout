class DashboardService
  # TODO: Should we do it more generative ?
  def initialize(repository:, payment_service:)
    @bundle_repository = repository
    @payment_service = payment_service
  end

  def get_dashboard_data
    {
      active_bundles: get_active_bundles
    }
  end

  def refresh_bundles
    BundleSyncJob.perform_later(payment_service_class: @payment_service.class.name, bundle_repository_class: @bundle_repository.class.name)
  end

  private

  def get_active_bundles
    @bundle_repository.get_active
  end
end
