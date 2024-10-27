class Order < ApplicationRecord
  belongs_to :bundle
  belongs_to :user

  enum payment_status: {
    unpaid: "unpaid",
    paid: "paid"
  }

  enum status: {
    open: "open",
    complete: "complete",
    expired: "expired"
  }
end
