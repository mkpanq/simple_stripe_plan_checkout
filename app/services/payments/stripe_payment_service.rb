module Payments
  class StripePaymentService < PaymentService
    def initialize
      super(StripeClient.new)
      @serializer = StripeBundleSerializer
    end

    def create_payment_process(bundle_id, user_email)
      @payment_client.generate_checkout_session(bundle_id, user_email)
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
