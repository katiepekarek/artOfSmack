class CreateTwitterEvents < ActiveRecord::Migration
  def change
    create_table :twitter_events do |t|
      t.string :type
      t.references :user, index: true, foreign_key: true
      t.string :uid
      t.string :text
      t.string :username
      t.string :handle
      t.string :hashtags

      t.timestamps null: false
    end
  end
end
