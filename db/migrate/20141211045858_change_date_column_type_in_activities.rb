class ChangeDateColumnTypeInActivities < ActiveRecord::Migration
  def change
    change_column(:activities, :date, :date)
  end
end
