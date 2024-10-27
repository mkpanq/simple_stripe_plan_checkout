class OrdersRepository
  def create_new_order(payment_session_id, bundle_id, user_id)
    Order.create!(
      payment_session_id: payment_session_id,
      bundle_id: bundle_id,
      user_id: user_id
    )
  end

  def find_by_payment_session_id(payment_session_id)
    Order.find_by(payment_session_id: payment_session_id)
  end

  def order_fullfill?(order)
    order.fulfillment_date.present?
  end

  def order_expired?(order)
    order.status == statuses[:expired]
  end

  def set_fullfill_date(order)
    order.update!(fulfillment_date: Time.now)
  end

  def close_payment(order)
    order.update!(payment_status: payment_statuses[:paid])
  end

  def close_order_status(order)
    order.update!(status: statuses[:closed])
  end

  def set_order_expire(order)
    order.update!(status: statuses[:expired])
  end
end
