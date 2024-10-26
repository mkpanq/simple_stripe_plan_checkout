class StripeBundleSerializer
  def self.call(products:, prices:)
    bundles = []
    prices.each do |price|
      product = products.find { |product| product.id == price.product }

      bundles << {
        # For now, I assume that each product will have one price and active will depend on product status itself
        active: product.active,
        bundle_id: price.id,
        name: product.name,
        description: product.description,
        recurring_type: price.recurring.interval,
        price: price.unit_amount,
        currency: price.currency
      }
    end

    bundles
  end
end
