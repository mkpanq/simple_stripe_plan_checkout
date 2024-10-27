class CheckoutService
  SUCCESS_EVENT_TYPES = [ "checkout.session.completed", "checkout.session.async_payment_succeeded" ]
  FAILURE_EVENT_TYPES = [ "checkout.session.async_payment_failed", "checkout.session.expired" ]

  def initialize(payment_service:, order_service:)
    @payment_service = payment_service
    @order_service = order_service
  end

  def create_new_checkout_session(bundle_id:, user_email:)
    process = @payment_service.create_payment_process(bundle_id, user_email)
    @order_service.create_new_order(process.id, bundle_id, user_email)

    process
  end

  def get_existing_checkout_session(session_id)
    session = @payment_service.retrieve_checkout_session_by_id(session_id)

    session
  end

  def get_bundle_data_from_session_id(session_id)
    order = @order_service.find_by_payment_session_id(session_id)

    @order_service.get_bundle_from_order(order)
  end

  def proceed_checkout_event_status(request:)
    event = @payment_service.get_payment_event_status(request)
    raise CustomErrors::UnhandeledEvent unless success_event?(event) || failure_event?(event)

    checkout_session = @payment_service.retrieve_checkout_session_from_event(event)
    order = @order_service.find_by_payment_session_id(checkout_session.id)
    @order_service.verify_order(order)

    if success_event?(event) && checkout_session.payment_status != "unpaid"
      fullfill_order(order)

      return
    end

    if failure_event?(event)
      failed_order(order)
    end
  end

  private

  def failed_order(order)
    @order_service.order_expired(order)
    # Send Email
    raise CustomErrors::OrderExpired
  end

  def fullfill_order(order)
    @order_service.fullfill_order(order)
    # Send email
  end

  def success_event?(event)
    event["type"].in?(SUCCESS_EVENT_TYPES)
  end

  def failure_event?(event)
    event["type"].in?(FAILURE_EVENT_TYPES)
  end
end
