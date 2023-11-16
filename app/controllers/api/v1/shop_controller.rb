class Api::V1::ShopController < ApplicationController
  def most_recent
    offset = params[:offset]
    render json: Seed.order(created_at: :desc)
                     .offset((offset unless !offset))
                     .limit(12)
  end
  def search
    keyword = params[:keyword].downcase
    offset = params[:offset]
    item_list = item_filter(Seed)
    item_list = price_filter(item_list)
    render json: item_list.where("tags LIKE ?", "%" + keyword + "%")
                     .offset((offset unless !offset))
                     .limit(12)
  end

  def active_banners
    render json: Banner.where(is_active?: true)
  end

  def get_item
    render json: Seed.find(params[:item_id])
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
    item_list = item_list.where("price >= #{params[:minimum]}") unless !params[:minimum]
    item_list = item_list.where("price <= #{params[:maximum]}") unless !params[:maximum]
    item_list
  end

end
