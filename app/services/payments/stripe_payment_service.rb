module Payments
  class StripePaymentService < PaymentService
    def initialize
      super(StripeClient.new, StripeBundleSerializer)
    end

    def create_payment_process(bundle_id, user_email)
      @payment_client.generate_checkout_session(bundle_id, user_email)
    end

    def get_payment_event_status(httpRequest)
      sig_header = httpRequest.env["HTTP_STRIPE_SIGNATURE"]
      payload = httpRequest.body.read

      @payment_client.construct_webhook_event(payload, sig_header)

    rescue JSON::ParserError
      raise CustomErrors::PayloadError
    rescue Stripe::SignatureVerificationError
      raise CustomErrors::SignatureError
    end

    def retrieve_checkout_session_by_id(checkout_session_id)
      @payment_client.retrieve_checkout_session(checkout_session_id)
    end

    def retrieve_checkout_session_from_event(event)
      checkout_session_id = event["data"]["object"]["id"]
      session = @payment_client.retrieve_checkout_session(checkout_session_id)
      raise CustomErrors::CheckoutSessionNotFound if session.nil?

      session
    end

    # def get_customer_orders
    #   raise NotImplementedError
    # end

    def fetch_and_serialize_products
      prices = @payment_client.get_all_prices
      products = @payment_client.get_all_products

      @serializer.call(prices: prices, products: products)
    end
  end
end
