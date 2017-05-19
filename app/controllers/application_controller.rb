class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_current_location, :unless => :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  def set_searched_in_session
    session[:searched] ||= {}
    session[:searched] = session[:searched].inject({}) { |memo, (k, v)| memo[k.to_sym] = v; memo}
  end

  private
    def store_current_location
      store_location_for(:user, request.url)
    end
end
