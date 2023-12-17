class Api::V1::ShopController < ApplicationController
  # GET /api/v1/shop
  def index
    offset = params[:offset]
    # Retrieve most recent items, ordered by creation date
    render json: {
      item_list: Item.order(created_at: :desc)
                     .offset(offset.presence)
                     .limit(25)
    }
  end

  # GET /api/v1/shop/search
  def search
    keyword = params[:keyword].downcase
    offset = params[:offset]
    # Filter items based on keyword and additional filters
    item_list = item_filter(price_filter(Item)).where("tags LIKE ?", "%#{keyword}%")
    render json: {
      item_list: item_list.offset(offset.presence).limit(20),
      item_count: item_list.count
    }
  end

  # GET /api/v1/shop/active_banners
  def active_banners
    # Retrieve active banners
    render json: Banner.where(is_active?: true)
  end

  # GET /api/v1/shop/:id
  def show
    # Retrieve details of a specific item
    render json: Item.find(params[:id])
  end

  # GET /api/v1/shop/items_properties
  def items_properties
    filters = Item.column_names
    # Retrieve distinct property values for items
    render json: filters.map { |attribute| [attribute, Item.distinct.pluck(attribute)] }
                      .to_h.except("id", "name", "price", "items_sold", "tags", "image_links", "created_at", "updated_at")
  end

  private

  # Apply additional filters to the item list
  def item_filter(item_list)
    return item_list if params[:filter].blank?

    params[:filter].each do |k, v|
      item_list = item_list.where(k => v)
    end

    item_list
  end

  # Apply price range filter to the item list
  def price_filter(item_list)
    item_list = item_list.where("price >= ?", params[:minimum]) unless params[:minimum].blank?
    item_list = item_list.where("price <= ?", params[:maximum]) unless params[:maximum].blank?
    item_list
  end
end
