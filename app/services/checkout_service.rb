class CheckoutService
  SUCCESS_EVENT_TYPES = [ "checkout.session.completed", "checkout.session.async_payment_succeeded" ]

  def initialize(payment_service:, order_service:)
    @payment_service = payment_service
    @order_service = order_service
  end

  def get_bundle_checkout(bundle_id:, user_email:)
    process = @payment_service.create_payment_process(bundle_id, user_email)
    @order_service.create_new_order(process.id, bundle_id, user_email)

    process
  end

  def proceed_checkout_event_status(request:)
    event = @payment_service.get_payment_event_status(request)
    fullfill_order(event) if check_event_type(event)
  end

  private

  def fullfill_order(event)
    checkout_session = @payment_service.retrieve_checkout_session_from_event(event)
    raise CustomErrors::SessionAlreadyCompleted if checkout_session.status == "complete"

    order = @order_service.find_by_payment_session_id(checkout_session.id)
    @order_service.verify_order_fullfillment(order)

    case checkout_session.status
    when "open"
      @order_service.fullfill_order(order)
      # Send Email
      # Return OK ?
    when "expired"
      @order_service.order_expired()
      # Return some error ?
    end
  end

  def check_event_type(event)
    event["type"].in?(SUCCESS_EVENT_TYPES)
  end
end
