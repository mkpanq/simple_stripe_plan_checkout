class Order < ApplicationRecord
  has_one :bundle
  has_one :user

  enum payment_status: {
    unpaid: "unpaid",
    paid: "paid"
  }

  enum status: {
    open: "open",
    closed: "closed",
    expired: "expired"
  }
end
