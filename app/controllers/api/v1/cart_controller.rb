class Api::V1::CartController < ApplicationController
  # GET /api/v1/cart
  def get_cart
    render json: current_user.carted_items.order(created_at: :desc), include: :item
  end

  # GET /api/v1/cart/for-checkout
  def get_for_checkout
    render json: current_user.carted_items.where(is_for_checkout: true).order(created_at: :desc), include: :item
  end

  # POST /api/v1/cart
  def add_to_cart
    carted_item = current_user.carted_items.find_by(item_id: params[:item_id])
    if carted_item
      carted_item.update(amount: params[:amount].to_i + carted_item.amount)
    else
      current_user.carted_items.create({item_id:params[:item_id], amount:params[:amount]})
    end
  end

  # PUT /api/v1/cart/update-amount/:carted_id/:amount
  def update_carted_amount
    return unless params[:amount] && params[:carted_id]
    CartedItem.find(params[:carted_id])
              .update(amount: params[:amount])
  end

  # PUT /api/v1/cart/update-amount/:carted_id/:is_for_checkout
  def update_checkout_status
    return unless params[:is_for_checkout] && params[:carted_id]
    CartedItem.find(params[:carted_id])
              .update(is_for_checkout: params[:is_for_checkout])
  end

  # DELETE /api/v1/cart/:carted_id
  def remove_from_cart
    CartedItem.find(params[:carted_id]).destroy
  end
end
