module ApplicationHelper
    def bootstrap_class_for flash_type # New flash type to be used with bootstrap alerts
	    case flash_type
	      when "notice"
	        "alert-success"   # Green
	      when "alert"
	        "alert-danger"    # Red
	      when "warning"
	        "alert-warning"   # Yellow
	      when "info"
	        "alert-info"      # Blue
	      else
	        flash_type.to_s
	    end
	end
	def is_admin?
        user_signed_in?
    end
end
