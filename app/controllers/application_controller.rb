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
  
  def after_sign_in_path_for(resource_or_scope)
    user_path(resource)
  end
  
  def after_sign_up_path_for(resource_or_scope)
    # if resource.email_required?
    #   super resource
    # else
      edit_user_path(resource)
    # end
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def ensure_signup_complete
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup'

    # Redirect to the 'edit_user' page if the user
    # email hasn't been verified yet
    if current_user && !User.confirmed? 
      redirect_to edit_user_path(resource)
    end
  end
  
end
