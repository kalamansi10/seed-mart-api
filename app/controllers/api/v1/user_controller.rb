class Api::V1::UserController < ApplicationController
  def get_shipping_addresses
    render json: current_user.shipping_addresses.order(created_at: :desc)
  end

  def add_shipping_addresses
    main_address = current_user.shipping_addresses.find_by(is_main: true)
    if current_user.shipping_addresses.create(shipping_address_params) && main_address && shipping_address_params[:is_main]
      main_address.update(is_main: false)
    end
  end

  def update_shipping_address
    main_address = current_user.shipping_addresses.find_by(is_main: true)
    if current_user.shipping_addresses.update(shipping_address_params) && main_address && shipping_address_params[:is_main]
      main_address.update(is_main: false)
    end
  end

  def remove_shipping_address
    ShippingAddress.find(params[:shipping_address_id]).destroy
  end

  private

  def shipping_address_params
    params.require(:shipping_address).permit(
      :contact_name,
      :contact_number,
      :street_address,
      :barangay,
      :city,
      :province,
      :region,
      :is_main
    )
  end
end
