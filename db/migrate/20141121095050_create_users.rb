class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :ic
      t.string :phone

      t.timestamps
    end
  end
end
