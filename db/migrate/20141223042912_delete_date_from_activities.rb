class DeleteDateFromActivities < ActiveRecord::Migration
  def up
    remove_column :activities, :date
  end

  def down
    add_column :activities, :date, :date
  end
end
