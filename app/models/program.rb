class Program < ActiveRecord::Base
    # Activity Association
    has_many :activities
    
    accepts_nested_attributes_for :activities, allow_destroy: true
    # , reject_if: lambda {|attributes| attributes['name'].blank?}
end
