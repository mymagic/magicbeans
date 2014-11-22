class AddConfirmableStuffToUsers < ActiveRecord::Migration
  def change
    add_column :users, :confirmable_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_out, :datetime
    add_column :users, :unconfirmed_email, :string
  end
end
