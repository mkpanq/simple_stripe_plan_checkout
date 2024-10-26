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
      # TODO: Add error handling
    rescue JSON::ParserError => e
      # Invalid payload
      status 400
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      status 400
    end

    def fullfill_order(event)
      checkout_session_id = event["data"]["object"]["id"]

      # TODO: Be sure this runs only once - check at "order / payment" object if has
      # "fullfilement date

      checkout_session = @payment_client.retrieve_checkout_session(checkout_session_id)

      if checkout_session.payment_status != "unpaid"
        # TODO: Perform fulfillment of the line items
        # TODO: Record/save fulfillment status for this
        # TODO: Save order in database
        # TODO: Send user an email
        # Checkout Session
        puts "----------------"
        puts "----------------"
        puts "----------------"
        puts "OK: Fulfilling order from session: #{payment_session_id}"
        puts "----------------"
        puts "----------------"
        puts "----------------"
      else
        # TODO: Handle error or do something else - need to be 100 % sure about payment_status
        puts "----------------"
        puts "----------------"
        puts "----------------"
        puts "ERROR Fulfilling order from session: #{payment_session_id}"
        puts "----------------"
        puts "----------------"
        puts "----------------"
      end
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
