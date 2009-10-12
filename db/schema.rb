# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091011170546) do

  create_table "photos", :force => true do |t|
    t.string   "flickr_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "twitter_status_id"
    t.string   "caption"
  end

  add_index "photos", ["flickr_id"], :name => "index_photos_on_flickr_id"
  add_index "photos", ["twitter_status_id"], :name => "index_photos_on_twitter_status_id"
  add_index "photos", ["user_id"], :name => "index_photos_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "twitter_username"
    t.string   "twitter_password"
    t.string   "flickr_user_id"
    t.string   "flickr_token"
    t.boolean  "test_user",        :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["flickr_user_id"], :name => "index_users_on_flickr_user_id"
  add_index "users", ["twitter_password"], :name => "index_users_on_twitter_password"
  add_index "users", ["twitter_username"], :name => "index_users_on_twitter_username", :unique => true

end
