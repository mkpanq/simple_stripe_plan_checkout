class CheckoutService
  SUCCESS_EVENT_TYPES = [ "checkout.session.completed", "checkout.session.async_payment_succeeded" ]

  def initialize(payment_service:)
    @payment_service = payment_service
  end

  def get_bundle_checkout(bundle_id:, user_email:)
    @payment_service.create_payment_process(bundle_id, user_email)
    # TODO: Here should cretae Order using order service
  end

  def proceed_checkout_event_status(request:)
    event = @payment_service.get_payment_event_status(request)
    @payment_service.fullfill_order(event) if check_event_type(event)
  end

  private

  def check_event_type(event)
    event["type"].in?(SUCCESS_EVENT_TYPES)
  end
end
