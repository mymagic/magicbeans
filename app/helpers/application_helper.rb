module ApplicationHelper
  def link_to_remove_fields(name, f, options = {})
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)", options)
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