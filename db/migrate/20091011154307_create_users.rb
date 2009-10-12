class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string  :twitter_username
      t.string  :twitter_password
      t.string  :flickr_user_id
      t.string  :flickr_token
      t.boolean :test_user, :default => false
      t.timestamps
    end
    
    add_index :users, :twitter_username, :unique => true
    add_index :users, :twitter_password
    add_index :users, :flickr_user_id
    
    add_column :photos, :user_id, :integer
    add_index :photos, :user_id
  end

  def self.down
    remove_column :photos, :user_id
    drop_table :users
  end
end
