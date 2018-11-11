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

ActiveRecord::Schema.define(version: 20181111115024) do

  create_table "populars", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "tweet_id"
    t.bigint "user_id"
    t.integer "retweet_count", null: false
    t.integer "favorite_count", null: false
    t.datetime "search_date"
    t.float "popular", limit: 24, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tweet_id"], name: "index_populars_on_tweet_id"
    t.index ["user_id"], name: "index_populars_on_user_id"
  end

  create_table "tweets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "tw_tweet_id", null: false
    t.bigint "user_id"
    t.string "text"
    t.string "urls"
    t.datetime "tweet_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tw_tweet_id"], name: "index_tweets_on_tw_tweet_id", unique: true
    t.index ["user_id"], name: "index_tweets_on_user_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "tw_user_id", null: false
    t.string "name"
    t.integer "followers_count", default: 0
    t.integer "statuses_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tw_user_id"], name: "index_users_on_tw_user_id", unique: true
  end

end
