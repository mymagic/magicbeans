class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  add_flash_types :warning, :success
  
  private

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  def reload_settings  
    Organizer::Config.access_token = Magicbeans.eventbrite_api
    Workspace::Application.config.time_zone = Magicbeans.time_zone
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    if current_user
      redirect_to :users, :alert => exception.message
    else
      redirect_to :root, :alert => exception.message
    end
  end
  

  
end
