class StripeClient
  require "stripe"

  # Should be constructed from main URL, but for now I just hardcoded it
  SUCCESS_URL = "http://localhost:3000/success?session_id={CHECKOUT_SESSION_ID}"
  CANCEL_URL = "http://localhost:3000/cancel?session_id={CHECKOUT_SESSION_ID}"

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
        success_url: SUCCESS_URL,
        cancel_url: CANCEL_URL
      }
    )
  end

  def retrieve_checkout_session(session_id)
    Stripe::Checkout::Session.retrieve({
        id: session_id,
        expand: [ "line_items" ]
      })
  end

  def construct_webhook_event(payload, sig_header)
    secret = Rails.application.credentials.stripe_webhook_secret
    Stripe::Webhook.construct_event(payload, sig_header, secret)
  end
end
