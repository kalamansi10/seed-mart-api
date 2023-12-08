class Api::V1::UserController < ApplicationController
  def get_shipping_addresses
    render json: current_user.shipping_addresses
  end
  def add_shipping_addresses
    current_user.shipping_addresses.create(shipping_address_params)
  end
  def update_shipping_address
  end
  def remove_shipping_address
    ShippingAddress.find(params[:shipping_address_id]).destroy
  end
  private
  def shipping_address_params
    params.require(:shipping_address).permit(:street_address, :barangay, :city, :province, :region)
  end
end
