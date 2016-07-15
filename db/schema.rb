# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160715090558) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "tweet_reminders", force: :cascade do |t|
    t.text     "name"
    t.text     "email_id"
    t.point    "location_point"
    t.boolean  "enable"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tweets", force: :cascade do |t|
    t.string   "tweet_id"
    t.datetime "tweet_created_at"
    t.string   "name"
    t.text     "profile_pic_url"
    t.string   "screen_name"
    t.text     "location"
    t.point    "location_point"
    t.string   "tweets_count"
    t.string   "followers_count"
    t.string   "following_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "location_lat",     default: 0.0
    t.float    "location_lng",     default: 0.0
  end

end
