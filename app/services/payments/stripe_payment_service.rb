module Payments
  class StripePaymentService < PaymentService
    require "stripe"

    def initialize
      super(Rails.application.credentials.stripe_api_key)
      Stripe.api_key = @service_api_key
    end

    # def create_payment_process
    #   raise NotImplementedError
    # end

    # def get_customer_orders
    #   raise NotImplementedError
    # end
  end
end
