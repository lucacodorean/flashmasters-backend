class BundleBuilder
  def self.build_bundle(name, price, description, icon, hours, questions)

    stripe_product = Stripe::Product.create(name: name, description: description, metadata: {})
    stripe_price   = Stripe::Price.create(product: stripe_product.id, unit_amount: price, currency: "ron")

    bundle = Bundle.create(
      name: name,
      price: price,
      description: description,
      icon: icon,
      hours: hours,
      price_id: stripe_price.id,
      product_id: stripe_product.id,
    )

    if questions
      bundle.questions = questions
    end

  end
end