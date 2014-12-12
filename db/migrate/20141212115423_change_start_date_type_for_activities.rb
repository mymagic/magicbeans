class ChangeStartDateTypeForActivities < ActiveRecord::Migration
  	def up
    change_column :activities, :start_date, :datetime
  	end

	  def down
	    change_column :activities, :start_date, :date
	  end
end