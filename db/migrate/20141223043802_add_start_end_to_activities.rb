class AddStartEndToActivities < ActiveRecord::Migration
  def up
    add_column :activities, :start, :date
    add_column :activities, :end, :date
  end

  def down
    remove_columns :activities, :start, :end
  end
end
