class Api::V1::CartController < ApplicationController
  def get_cart
    render json: current_user.carted_items.order(created_at: :desc), include: :item
  end
  def get_for_checkout
    render json: current_user.carted_items.where(is_for_checkout: true).order(created_at: :desc), include: :item
  end
  def add_to_cart
    carted_item = current_user.carted_items.find_by(item_id: params[:item_id])
    if carted_item
      carted_item.update(amount: params[:amount].to_i + carted_item.amount)
    else
      current_user.carted_items.create({item_id:params[:item_id], amount:params[:amount]})
    end
  end
  def update_cart
    carted_item = CartedItem.find(params[:carted_id])
    carted_item.update(amount: params[:amount]) if params[:amount]
    carted_item.update(is_for_checkout: params[:is_for_checkout]) if params[:is_for_checkout]
  end
  def remove_from_cart
    CartedItem.find(params[:carted_id]).destroy
  end
end
