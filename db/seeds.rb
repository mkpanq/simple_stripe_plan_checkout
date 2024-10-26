User.first_or_create(
  username: "John Kowalski",
  email:  "john@myemail.com",
  password: "password",
  password_confirmation: "password"
)

Bundle.first_or_create(
  [
    {
      active: true,
      bundle_id: "basic_monthly_1",
      name: "Basic",
      description: "Basic bundle with very limited features",
      price: 10,
      currency: "USD",
      recurring_type: "monthly"
    },
    {
      active: true,
      bundle_id: "pro_monthly_1",
      name: "Pro",
      description: "Pro bundle with Basic features + much more",
      price: 50,
      currency: "USD",
      recurring_type: "monthly"
    },
    {
      active: true,
      bundle_id: "enterprise_monthly_1",
      name: "Enterprise",
      description: "Enterprise bundle with all features for large companies",
      price: 500,
      currency: "USD",
      recurring_type: "monthly"
    }
  ]
)
