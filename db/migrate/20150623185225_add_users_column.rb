class AddUsersColumn < ActiveRecord::Migration
  def change
    add_column :users, :bleacher_id, :integer
    add_column :users, :email, :string
    add_column :users, :teams, :text
  end
end
