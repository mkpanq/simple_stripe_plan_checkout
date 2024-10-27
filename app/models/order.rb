class Order < ApplicationRecord
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
