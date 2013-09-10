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

ActiveRecord::Schema.define(version: 20130909225006) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: true do |t|
    t.string   "name"
    t.datetime "date"
  end

  create_table "events_search_terms", force: true do |t|
    t.integer "event_id"
    t.integer "search_term_id"
  end

  create_table "redis_trips", force: true do |t|
    t.integer  "tweet_count"
    t.time     "timestamps"
    t.integer  "short_ema"
    t.integer  "long_ema"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "macd"
    t.integer  "signal_line"
    t.integer  "histogram"
    t.integer  "search_term_id"
  end

  create_table "search_terms", force: true do |t|
    t.string "hashtag"
  end

  create_table "spikes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "redis_trip_id"
  end

end
