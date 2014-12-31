class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :title
      t.string :log_type
      t.integer :type_id

      t.timestamps
    end
  end
end
