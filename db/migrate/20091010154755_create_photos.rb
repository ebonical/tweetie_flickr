class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.string :flickr_id
      t.timestamps
    end
    
    add_index :photos, :flickr_id
  end

  def self.down
    drop_table :photos
  end
end
