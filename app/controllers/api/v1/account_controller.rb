class Api::V1::AccountController < ApplicationController
    # GET "api/v1/account/shipping-address/list"
  def get_shipping_address_list
    render json: current_user.shipping_addresses.order(created_at: :desc)
  end

  # POST "api/v1/account/shipping-address"
  def add_shipping_address
    main_address = current_user.shipping_addresses.find_by(is_main: true)
    if current_user.shipping_addresses.create(shipping_address_params) && main_address && shipping_address_params[:is_main]
      main_address.update(is_main: false)
    end
  end

  # PUT "api/v1/account/shipping-address"
  def update_shipping_address
    main_address = current_user.shipping_addresses.find_by(is_main: true)
    address_to_update = ShippingAddress.find(shipping_address_params[:id])
    if address_to_update.update(shipping_address_params) && main_address && shipping_address_params[:is_main]
      main_address.update(is_main: false)
    end
  end

  # DELETE "api/v1/account/shipping-address"
  def remove_shipping_address
    ShippingAddress.find(params[:shipping_address_id]).destroy
  end

  private

  def shipping_address_params
    params.require(:shipping_address).permit(
      :id,
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
