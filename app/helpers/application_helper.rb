module ApplicationHelper
	def bootstrap_class_for flash_type # New flash type to be used with bootstrap alerts
		case flash_type
		  when "success"
		    "alert-success"   # Green
		  when "alert"
		    "alert-danger"    # Red
		  when "warning"
		    "alert-warning"   # Yellow
		  when "notice"
		    "alert-info"      # Blue
		  else
		    flash_type.to_s
		end
	end

	def button_to_add_field(f, association)  
		new_object = f.object.send(association).klass.new 
		fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|  
		  render("shared/" + association.to_s.singularize + "_field", :f => builder)  
		end 
		button = "<button type='button' class='btn btn-primary' onclick='add_field(this, \"#{association}\", \"#{escape_javascript(fields)}\")' formnovalidate data-loading-text='Loading...'><span class='glyphicon glyphicon-plus'></span></button>"
		button.html_safe
	end

	def image_for(resource)
		placeholder = "http://placehold.it/150x150"
		if resource.class == Program
			resource.program_img.url.nil? ? placeholder : resource.program_img.url
		elsif resource.class == Activity
			resource.activity_img.url.nil? ? placeholder : resource.activity_img.url
		end
	end

	def image_for_speaker(resource)
		placeholder = "http://placehold.it/150x150"
		if resource.class == Program
			resource.speaker_img.url.nil? ? placeholder : resource.speaker_img.url
		elsif resource.class == Activity
			resource.speaker_img.url.nil? ? placeholder : resource.speaker_img.url
		end
	end
end
