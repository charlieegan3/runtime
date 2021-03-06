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

ActiveRecord::Schema.define(version: 20141019130919) do

  create_table "distances", force: true do |t|
    t.string   "identifier"
    t.float    "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ratios", force: true do |t|
    t.float    "distance1"
    t.float    "distance2"
    t.float    "multiplier"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "certainty"
  end

  create_table "runners", force: true do |t|
    t.integer  "age"
    t.string   "gender"
    t.integer  "fitness"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "query_distance"
  end

  create_table "runs", force: true do |t|
    t.float    "distance"
    t.time     "racetime"
    t.integer  "runner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "seconds"
    t.integer  "minutes"
    t.integer  "hours"
  end

  add_index "runs", ["runner_id"], name: "index_runs_on_runner_id"

end
