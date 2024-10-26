module Payments
  class PaymentService
    def initialize(api_key = nil)
      @service_api_key = api_key
    end

    def create_payment_process
      raise NotImplementedError
    end

    def get_customer_orders
      raise NotImplementedError
    end

    # create session
    # get orders
    # other related to webhooks
  end
end
