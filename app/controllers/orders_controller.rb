class OrdersController < ApplicationController
  def index
    @orders = orders_service.get_all_for_current_user(current_user.id)
  end

  private

  def orders_service
    OrdersService.new(
      order_repository: OrdersRepository.new,
      user_repository: UserRepository.new,
      bundle_repository: BundleRepository.new
    )
  end
end
