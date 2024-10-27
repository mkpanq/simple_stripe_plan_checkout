class Order < ApplicationRecord
  belongs_to :bundle

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
