module Payments
  class PaymentService
    def initialize(payment_client, products_serializer)
      @payment_client = payment_client
      @serializer = products_serializer
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

    def fullfill_order
      raise NotImplementedError
    end
  end
end
