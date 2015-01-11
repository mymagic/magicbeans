class AddListedOnlineToActivities < ActiveRecord::Migration
  def up
    add_column :activities, :listed, :boolean, default: true
    add_column :activities, :online, :boolean, default: true
  end

  def down
    remove_columns :activities, :listed, :online
  end
end
