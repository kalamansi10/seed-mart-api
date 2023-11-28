class Api::V1::CartController < ApplicationController
  def get_cart
    render json: current_user.carted.order(created_at: :desc), include: {seed: {only: [:name, :price, :image_links]}}
  end
  def add_to_cart
    cart_item = current_user.carted.find_by(item_id: params[:item_id])

    if cart_item
      cart_item.update(amount: params[:amount].to_i + cart_item.amount)
    else
      current_user.carted.create({item_id:params[:item_id], amount:params[:amount]})
    end
  end
  def update_cart
    carted = Carted.find(params[:carted_id])
    carted.update(amount: params[:amount]) if params[:amount]
    carted.update(checkout: params[:checkout]) if params[:checkout]
  end
  def remove_from_cart
    Carted.find(params[:carted_id]).destroy
  end
end
