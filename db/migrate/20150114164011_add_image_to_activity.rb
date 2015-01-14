class AddImageToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :activity_img, :string
    add_column :activities, :speaker_img, :string
  end
end
