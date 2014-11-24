class Program < ActiveRecord::Base
    
    # Timezone Association
    has_many :activities
    
    accepts_nested_attributes_for :activities, allow_destroy: true
end
