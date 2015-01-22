class AddImagesToProgram < ActiveRecord::Migration
  def change
    add_column :programs, :speaker_img, :string
    add_column :programs, :program_img, :string
  end
end
