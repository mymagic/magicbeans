class RemoveOldDatesFromActivities < ActiveRecord::Migration
  def change
    remove_column :activities, :start, :date
    remove_column :activities, :end, :date
  end
end
