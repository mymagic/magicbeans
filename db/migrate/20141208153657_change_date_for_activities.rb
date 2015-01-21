class ChangeDateForActivities < ActiveRecord::Migration
  	def up
    change_column :activities, :date, :datetime
  	end

	  def down
	    change_column :activities, :date, :date
	  end
end
