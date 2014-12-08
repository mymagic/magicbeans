class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :title
      t.string :log_type

      t.timestamps
    end
  end
end
