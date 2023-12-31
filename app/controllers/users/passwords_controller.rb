# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  before_action :ensure_normal_user, only: [:create]

  private
    def ensure_normal_user
      if params[:user][:email].downcase == 'guest@example.com'
        redirect_to new_user_sessions_path, alert: 'ゲストユーザーのパスワード再設定はできません。'
      end
    end
end
