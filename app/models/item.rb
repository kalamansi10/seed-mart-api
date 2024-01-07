class Item < ApplicationRecord
  has_many :carted_items
  has_many :orders, dependent: :destroy
  has_many :reviews, dependent: :destroy
end
