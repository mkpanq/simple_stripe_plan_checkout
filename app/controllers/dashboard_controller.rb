class DashboardController < ApplicationController
  def home
    @dashboard_data = dashboard_data_service.get_dashboard_data
  end

  private

  def dashboard_data_service
    @dashboard_service_data ||= DashboardService.new
  end
end
