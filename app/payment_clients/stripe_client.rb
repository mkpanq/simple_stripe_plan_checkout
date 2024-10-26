class StripeClient
  require "stripe"

  attr_reader :serializer

  def initialize
    Stripe.api_key = Rails.application.credentials.stripe_api_key
    @serializer = StripeBundleSerializer
  end

  def get_all_prices
    Stripe::Price.list["data"]
  end

  def get_all_products
    Stripe::Product.list["data"]
  end
end
