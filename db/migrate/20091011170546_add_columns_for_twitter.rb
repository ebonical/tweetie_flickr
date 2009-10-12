class AddColumnsForTwitter < ActiveRecord::Migration
  def self.up
    add_column :photos, :twitter_status_id, :string
    add_column :photos, :caption, :string
    
    add_index :photos, :twitter_status_id
  end

  def self.down
    remove_column :photos, :twitter_status_id
    remove_column :photos, :caption
  end
end
