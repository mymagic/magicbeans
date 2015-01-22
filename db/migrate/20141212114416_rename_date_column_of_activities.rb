class RenameDateColumnOfActivities < ActiveRecord::Migration
  def change
  	rename_column :activities, :date, :start_date
  end
end
