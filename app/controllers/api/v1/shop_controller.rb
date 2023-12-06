class Api::V1::ShopController < ApplicationController
  def most_recent
    offset = params[:offset]
    render json: Item.order(created_at: :desc)
                     .offset((offset unless !offset))
                     .limit(12)
  end
  def search
    keyword = params[:keyword].downcase
    offset = params[:offset]
    item_list = item_filter(Item)
    item_list = price_filter(item_list)
    render json: item_list.where("tags LIKE ?", "%" + keyword + "%")
                     .offset((offset unless !offset))
                     .limit(12)
  end

  def active_banners
    render json: Banner.where(is_active?: true)
  end

  def get_item
    render json: Item.find(params[:item_id])
  end

  def items_properties
    filters = Item.column_names.except("id", "name", "price", "tags", "image_links", "created_at", "updated_at")
    render json: filters.map { |attribute| [attribute, Item.distinct.pluck(attribute)] }.to_h
  end

  private

  def item_filter(item_list)
    return item_list if !params[:filter]
    params[:filter].each do |k, v|
      item_list = item_list.where(k => v)
    end
    item_list
  end

  def price_filter(item_list)
    item_list = item_list.where("price >= ?", params[:minimum]) unless params[:minimum].blank?
    item_list = item_list.where("price <= ?", params[:maximum]) unless params[:maximum].blank?
    item_list
  end

end
