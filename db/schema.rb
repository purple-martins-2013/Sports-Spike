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

ActiveRecord::Schema.define(version: 20130907204040) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: true do |t|
    t.string   "name"
    t.datetime "date"
  end

  create_table "redis_trips", force: true do |t|
    t.datetime "time"
    t.integer  "tweet_count"
  end

  create_table "spikes", force: true do |t|
    t.datetime "date_time"
    t.integer  "peak_velocity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
  end

  create_table "tweets", force: true do |t|
    t.integer  "tweet_id"
    t.string   "text"
    t.string   "username"
    t.integer  "userid"
    t.string   "received_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
