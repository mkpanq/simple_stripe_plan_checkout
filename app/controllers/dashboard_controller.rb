class DashboardController < ApplicationController
  # TODO: Handle errors!

  def home
    @dashboard_data = dashboard_data_service.get_dashboard_data
  end

  def get_checkout
    session = dashboard_data_service.get_bundle_checkout(bundle_id: params[:bundle_id], user_email: current_user.email)
    redirect_to session.url, status: 303, allow_other_host: true
  end

  def refresh_bundles
    dashboard_data_service.refresh_bundles
  end

  private

  def dashboard_data_service
    @dashboard_service_data ||= DashboardService.new(
      repository: BundleRepository.new,
      payment_service: Payments::StripePaymentService.new
    )
  end
end
