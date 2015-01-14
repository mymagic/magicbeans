class RemoveUnusedStuffFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :photo, :string
    remove_column :users, :uid, :string
    remove_column :users, :token, :string
    remove_column :users, :provider, :string
  end
end
