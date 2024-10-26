module Payments
  class StripePaymentService < PaymentService
    def initialize
      super(StripeClient.new)
      @serializer = StripeBundleSerializer
    end

    # def create_payment_process
    #   raise NotImplementedError
    # end

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
