class ChangeEventIdTypeForActivities < ActiveRecord::Migration
  def change
  	change_column :activities, :event_id, :string
  end
end
