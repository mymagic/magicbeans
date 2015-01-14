class ChangeDateTypeOfActivities < ActiveRecord::Migration
  def up
    change_column :activities, :start_date, :datetime_local
    change_column :activities, :end_date, :datetime_local
  	end

  def down
	change_column :activities, :start_date, :datetime
	change_column :activities, :end_date, :datetime
  end
end
