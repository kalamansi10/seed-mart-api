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

  def update_carted_amount
    return unless params[:amount] && params[:carted_id]
    CartedItem.find(params[:carted_id])
              .update(amount: params[:amount])
  end

  def update_checkout_status
    return unless params[:is_for_checkout] && params[:carted_id]
    CartedItem.find(params[:carted_id])
              .update(is_for_checkout: params[:is_for_checkout])
  end

  def remove_from_cart
    CartedItem.find(params[:carted_id]).destroy
  end

  def is_cart_empty?
    render json: { is_cart_empty: current_user.carted_items.empty? }
  end
end
