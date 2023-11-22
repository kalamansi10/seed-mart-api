class Api::V1::CartController < ApplicationController
  def get_cart
    render json: current_user.carted.order(created_at: :desc), include: {seed: {only: [:name, :price, :image_links]}}
  end
  def add_to_cart
    cart_item = current_user.carted.find_by(item_id: params[:item_id])

    if cart_item
      cart_item.update(amount: params[:amount].to_i + cart_item.amount)
    else
      carted = current_user.carted.build
      carted.item_id = params[:item_id]
      carted.amount = params[:amount]
      carted.save
    end
  end
  def update_cart
    Carted.find(params[:carted_id]).update(amount: params[:amount])
  end
  def remove_from_cart
    Carted.find(params[:carted_id]).destroy
  end
end
