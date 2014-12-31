class AddEventidToActivities < ActiveRecord::Migration
  def up
    add_column :activities, :event_id, :integer
  end

  def down
    remove_column :activities, :event_id
  end
end
