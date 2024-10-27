class Order < ApplicationRecord
  has_one :bundle
  has_one :user
end
