class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  #For Public Activity
  include PublicActivity::StoreController

  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  hide_action :current_user

  protected

  def configure_permitted_parameters  
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :role])
	   devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :role])  
  end
 

end
