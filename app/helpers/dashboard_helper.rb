module DashboardHelper
  require "money"

  def price_name(price, currency)
    Money.from_cents(price, currency).format
  end
end
