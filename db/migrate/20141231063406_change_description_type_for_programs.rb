class ChangeDescriptionTypeForPrograms < ActiveRecord::Migration
  def change
    change_column :programs, :description, :text
  end
end
