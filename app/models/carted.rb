class Carted < ApplicationRecord
  belongs_to :user
  belongs_to :seed, foreign_key: :item_id
end
