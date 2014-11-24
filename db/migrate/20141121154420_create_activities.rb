class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.string :date
      t.string :venue
      t.text :description
      t.string :speaker
      t.text :speakerbio
      t.string :biolink
      t.string :keytakeaway
      t.text :prerequisite
      t.integer :maxattendee
      t.string :tags
      t.string :resources

      t.timestamps
    end
  end
end
