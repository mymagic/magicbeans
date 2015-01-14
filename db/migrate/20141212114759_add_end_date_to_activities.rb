class AddEndDateToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :end_date, :datetime
  end
end
