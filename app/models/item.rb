class Item < ApplicationRecord
  has_many :carted_items
  has_many :orders
end
