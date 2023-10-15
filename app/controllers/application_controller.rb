class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?

    private

    def sign_in_required
        redirect_to login_url unless user_signed_in?
    end

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [
          :name, 
          :birthdate,
          :sex, 
          :job
        ])
        devise_parameter_sanitizer.permit(:account_update, keys: [
          :name, 
          :birthdate,
          :sex, 
          :job
        ])
      end
end
