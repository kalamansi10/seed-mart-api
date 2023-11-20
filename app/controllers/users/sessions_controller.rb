# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController

  # repurposed for checking if user is currently logged in
  def new
    render json: current_user
  end

  def create
    self.resource = warden.authenticate!(auth_options)
  end

  def destroy
    sign_out current_user
  end
end
