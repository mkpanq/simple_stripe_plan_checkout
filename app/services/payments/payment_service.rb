module Payments
  class PaymentService
    def initialize(payment_client)
      @payment_client = payment_client
    end

    def create_payment_process
      raise NotImplementedError
    end

    def get_customer_orders
      raise NotImplementedError
    end

    def fetch_and_serialize_products
      raise NotImplementedError
    end

    # create session
    # get orders
    # other related to webhooks
  end
end
