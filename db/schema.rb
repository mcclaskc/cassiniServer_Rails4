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

ActiveRecord::Schema.define(version: 20130502155706) do

  create_table "bodies", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data_files", force: true do |t|
    t.string   "path"
    t.date     "file_date"
    t.integer  "file_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "body_id"
  end

  create_table "ephems", force: true do |t|
    t.float    "x"
    t.float    "y"
    t.float    "z"
    t.datetime "timestamp"
    t.integer  "body_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "request"
    t.string   "start_scet"
    t.string   "end_scet"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "file_types", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
