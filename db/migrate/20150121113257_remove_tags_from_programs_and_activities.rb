class RemoveTagsFromProgramsAndActivities < ActiveRecord::Migration
  def change
    remove_column :programs, :tags, :string
    remove_column :activities, :tags, :string
  end
end
