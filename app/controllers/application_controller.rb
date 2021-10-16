class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_current_user

    def set_current_user
      User.current = current_user
    end

    def authorize_admin
        redirect_to :back, :status => 401 unless current_user.admin
    rescue ActionController::RedirectBackError
        redirect_to root_path
    end
        #redirects to previous page

    protected

        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first, :last, :email, :password, :group_id) }
            devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first, :last, :email, :password, :current_password, :group_id, :avatar) }
        end
end
