class Item < ApplicationRecord
  has_many :carted_items
  has_many :orders
  has_many :reviews, dependent: :destroy

  def self.get(item_id)
    includes(:reviews, :orders)
      .find(item_id)
      .as_json(
        methods: [:average_rating, :item_sold],
        except: [:created_at, :updated_at]
      )
  end

  def item_sold
    orders.count
  end

  def average_rating
    total_reviews = reviews.count
    return 0 if total_reviews.zero?

    total_rating = reviews.pluck(:rating).reduce(:+)
    total_rating.to_f / total_reviews.round
  end
end
