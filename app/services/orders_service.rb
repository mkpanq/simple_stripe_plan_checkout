class OrdersService
  def initialize(order_repository:, user_repository:, bundle_repository:)
    @order_repository = order_repository
    @user_repository = user_repository
    @bundle_repository = bundle_repository
  end

  def get_all_for_current_user(id)
    @order_repository.find_by_user_id(id)
  end

  def create_new_order(payment_session_id, bundle_id, user_email)
    user_id = @user_repository.find_by_user_email(user_email).id
    bundle = @bundle_repository.find_by_bundle_id(bundle_id)
    @order_repository.create_new_order(payment_session_id, bundle.id, user_id)
  end

  def get_bundle_from_order(order)
    @bundle_repository.find(order.bundle_id)
  end

  def find_by_payment_session_id(payment_session_id)
    @order_repository.find_by_payment_session_id(payment_session_id)
  end

  def verify_order(order)
    raise CustomErrors::OrderNotFound if order.nil?
    raise CustomErrors::OrderExpired if @order_repository.order_expired?(order)
    raise CustomErrors::OrderAlreadyFulfilled if @order_repository.order_fullfill?(order)
  end

  def fullfill_order(order)
    @order_repository.set_fullfill_date(order)
    @order_repository.close_payment(order)
    @order_repository.close_order_status(order)
  end

  def order_expired(order)
    @order_repository.set_order_expire(order)
  end
end
