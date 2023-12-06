class Order < ApplicationRecord
  belongs_to :user
  belongs_to :item
  belongs_to :shipping_address
  belongs_to :payment_method
end
