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

ActiveRecord::Schema.define(version: 20181125110513) do

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC" do |t|
    t.string "name", null: false
    t.string "label", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "populars", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC" do |t|
    t.bigint "tweet_id"
    t.bigint "user_id"
    t.integer "retweet_count", null: false
    t.integer "favorite_count", null: false
    t.datetime "search_date"
    t.float "popular", limit: 24, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id"
    t.index ["category_id"], name: "index_populars_on_category_id"
    t.index ["tweet_id"], name: "index_populars_on_tweet_id"
    t.index ["user_id"], name: "index_populars_on_user_id"
  end

  create_table "tweets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC" do |t|
    t.string "tw_tweet_id", null: false
    t.bigint "user_id"
    t.string "text"
    t.bigint "category_id"
    t.string "link"
    t.string "urls"
    t.datetime "tweet_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_tweets_on_category_id"
    t.index ["tw_tweet_id"], name: "index_tweets_on_tw_tweet_id", unique: true
    t.index ["user_id"], name: "index_tweets_on_user_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC" do |t|
    t.string "tw_user_id", null: false
    t.string "name"
    t.string "screen_name"
    t.integer "followers_count", default: 0
    t.integer "statuses_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tw_user_id"], name: "index_users_on_tw_user_id", unique: true
  end

  add_foreign_key "tweets", "categories"
end
