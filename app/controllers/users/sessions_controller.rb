# frozen_string_literal: true
class Users::SessionsController < Devise::SessionsController

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to root_path, notice: 'ゲストとしてログインしました。'
  end
  
  def check_login_status
    render json: { loggedIn: user_signed_in? }
  end
end
