class Api::V1::UserController < ApplicationController
  def get_shipping_addresses
    render json: current_user.shipping_addresses
  end
end
