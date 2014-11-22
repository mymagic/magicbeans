class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :name
      t.string :description
      t.string :speaker
      t.string :speakerbio
      t.string :biourl
      t.string :keytakeways
      t.string :tags
      t.string :resources

      t.timestamps
    end
  end
end
