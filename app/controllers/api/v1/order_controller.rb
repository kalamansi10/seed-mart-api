class Api::V1::OrderController < ApplicationController
  # GET /api/v1/order/:reference_id
  def get_order
    render json: Order.where(order_reference: params[:reference_id])
  end

  # POST /api/v1/order
  def process_order
    reference_number = generate_reference_number

    orders_params.each do |order|
      unless create_order(reference_number, order)
        render json: { error: order.errors.full_messages.join(", ") }, status: :unprocessable_entity
        return
      end
      remove_carted(order[:carted_id])
    end

    render json: { message: "Orders processed successfully", reference_number: reference_number }
  end

  # GET /api/v1/order/list
  def get_order_list
    render json: current_user.orders.order(created_at: :desc), include: [:item]
  end

  # POST /api/v1/order/status
  def update_order_status
    order = Order.where(order_reference: params[:order][:order_reference])
    order.update(status: params[:order][:status])
  end

  private

  def create_order(reference_number, order)
    current_user.orders.create(
      order_reference: reference_number,
      item_id: order[:item_id],
      shipping_address_id: order[:shipping_address_id],
      payment_method_id: order[:payment_method_id],
      amount: order[:amount],
      adjustments: order[:adjustments],
      total: order[:total],
      status: "To Receive"
    )
  end

  def generate_reference_number
    prefix = "SEED"
    random_numbers = Array.new(5) { rand(10) }.join
    timestamp = Time.now.strftime("%Y%m%d")
    "#{prefix}#{random_numbers}#{timestamp}"
  end

  def remove_carted(carted_id)
    CartedItem.find(carted_id).destroy if carted_id
  end

  def orders_params
    params.require(:order_list).map do |order|
      order.permit(
        :item_id,
        :shipping_address_id,
        :payment_method_id,
        :amount,
        :adjustments,
        :total,
        :carted_id
      )
    end
  end
end
