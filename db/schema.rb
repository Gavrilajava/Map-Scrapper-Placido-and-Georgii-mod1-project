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

ActiveRecord::Schema.define(version: 2020_02_14_153009) do

  create_table "keywords", force: :cascade do |t|
    t.string "keyword"
    t.integer "relevance"
  end

  create_table "matches", force: :cascade do |t|
    t.integer "page_id"
    t.integer "keyword_id"
    t.integer "count"
  end

  create_table "pages", force: :cascade do |t|
    t.integer "place_id"
    t.string "url"
    t.boolean "visited"
  end

  create_table "place_tag_joiners", force: :cascade do |t|
    t.integer "place_id"
    t.integer "tag_id"
  end

  create_table "places", force: :cascade do |t|
    t.string "name"
    t.float "distance"
    t.string "category"
    t.string "address"
    t.string "website"
  end

  create_table "searches", force: :cascade do |t|
    t.float "radius"
  end

  create_table "tags", force: :cascade do |t|
    t.string "title"
    t.string "group"
    t.integer "relevance"
  end

  create_table "webpages", force: :cascade do |t|
    t.string "domain"
    t.string "page"
    t.text "content"
    t.boolean "visited"
  end

end
