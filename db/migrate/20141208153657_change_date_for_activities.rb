class ChangeDateForActivities < ActiveRecord::Migration
  	def up
    change_column :activities, :date, :datetime, 'datetime USING CAST(date AS datetime)'
  	end

	  def down
	    change_column :activities, :date, :date
	  end
end
