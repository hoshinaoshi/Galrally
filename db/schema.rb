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

ActiveRecord::Schema.define(version: 20130824050652) do

  create_table "admin_users", force: true do |t|
    t.string   "name"
    t.string   "pass"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blogs", force: true do |t|
    t.string   "title"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "show_id"
  end

  add_index "blogs", ["show_id"], name: "index_blogs_on_show_id", using: :btree

  create_table "reviews", force: true do |t|
    t.string   "movie_id"
    t.string   "thumbnail_url"
    t.integer  "site"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["site"], name: "index_reviews_on_site", using: :btree

  create_table "scraping_histories", force: true do |t|
    t.string   "movie_id"
    t.integer  "site"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scraping_histories", ["site"], name: "index_scraping_histories_on_site", using: :btree

  create_table "shows", force: true do |t|
    t.string   "movie_id"
    t.string   "thumbnail_url"
    t.integer  "site"
    t.boolean  "scraping_flag"
    t.boolean  "new_flag"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tag_id"
    t.integer  "blog_id"
  end

  add_index "shows", ["blog_id"], name: "index_shows_on_blog_id", using: :btree
  add_index "shows", ["new_flag"], name: "index_shows_on_new_flag", using: :btree
  add_index "shows", ["scraping_flag"], name: "index_shows_on_scraping_flag", using: :btree
  add_index "shows", ["site"], name: "index_shows_on_site", using: :btree
  add_index "shows", ["tag_id"], name: "index_shows_on_tag_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["tag"], name: "index_tags_on_tag", using: :btree

end
