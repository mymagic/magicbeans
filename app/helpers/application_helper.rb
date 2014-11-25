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

	def button_to_add_field(f, association)  
		new_object = f.object.send(association).klass.new 
		fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|  
		  render(association.to_s.singularize + "_field", :f => builder)  
		end 
		button = "<button type='button' class='btn btn-primary' onclick='add_field(this, \"#{association}\", \"#{escape_javascript(fields)}\")' formnovalidate data-loading-text='Loading...'><span class='glyphicon glyphicon-plus'></span></button>"
		button.html_safe
	end  
end
