class Api::V1::MiscController < ApplicationController
  # GET /api/v1/misc/active-banners
  def get_active_banners
    render json: Banner.where(is_active?: true)
  end

  # GET /api/v1/misc/item-properties
  def get_item_properties
    filters = Item.column_names - ["id", "name", "price", "items_sold", "tags", "image_links", "created_at", "updated_at"]
    # Retrieve distinct property values for items
    render json: filters.map { |attribute| [attribute, Item.distinct.pluck(attribute)] }.to_h
  end
end
