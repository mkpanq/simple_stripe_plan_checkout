class StripeClient
  require "stripe"

  attr_reader :serializer

  def initialize
    Stripe.api_key = Rails.application.credentials.stripe_api_key
  end

  def get_all_prices
    Stripe::Price.list["data"]
  end

  def get_all_products
    Stripe::Product.list["data"]
  end

  def generate_checkout_session(bundle_id, user_email)
    Stripe::Checkout::Session.create(
      {
        line_items: [
          {
            price: bundle_id,
            quantity: 1
          }
        ],
        mode: "subscription",
        customer_email: user_email,

        # TODO:
        success_url: "http://localhost:3000/",
        cancel_url: "http://localhost:3000/"
      }
    )
  end
end
