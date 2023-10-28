# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: [:update]
  before_action :sign_in_required, only: [:edit, :update]
  before_action :ensure_normal_user, only: [:update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(sign_up_params)
    if @user.save
      redirect_to sign_up_complete_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  def complete
  end

  def edit
    super
  end

  def update
    super
  end

  private

  def ensure_normal_user
    if resource.email == 'guest@example.com'
        redirect_to root_path, alert: 'ゲストユーザーの更新・削除はできません。'
    end
  end

  def update_resource(resource, params)
    resource.update_without_current_password(params)
  end

  def after_update_path_for(_resource)
    root_path
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :name, 
      :birthdate, 
      :job, 
      :sex
      ]
    )
  end
end
