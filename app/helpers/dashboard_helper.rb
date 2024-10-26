module DashboardHelper
  def recurring_price_name(bundle)
    "#{number_to_currency(bundle.price, unit: convert_currency_name_to_symbol[bundle.currency])} / #{bundle.recurring_type}"
  end

  def convert_currency_name_to_symbol
    {
      "USD" => "$",
      "EUR" => "€",
      "PLN" => "zł"
    }
  end
end
