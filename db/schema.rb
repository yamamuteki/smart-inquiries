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

ActiveRecord::Schema.define(version: 20151201150536) do

  create_table "distributions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inquiries", force: :cascade do |t|
    t.string   "content"
    t.integer  "respondent_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "respondents", force: :cascade do |t|
    t.string   "email"
    t.integer  "distribution_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "uuid"
    t.datetime "first_sent_at"
    t.datetime "last_sent_at"
    t.integer  "sent_count"
    t.datetime "accessed_at"
    t.datetime "answered_at"
  end

end
