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

ActiveRecord::Schema.define(version: 20150726085427) do

  create_table "comps", force: :cascade do |t|
    t.string  "sensu_name",   limit: 255
    t.string  "ipaddress",    limit: 255
    t.integer "cpunum",       limit: 4
    t.integer "total_memory", limit: 4
  end

  add_index "comps", ["sensu_name"], name: "index_comps_on_sensu_name", using: :btree

  create_table "stats", force: :cascade do |t|
    t.integer "timestamp",           limit: 4
    t.integer "comp_id",             limit: 4
    t.float   "load_one",            limit: 24
    t.float   "load_five",           limit: 24
    t.float   "load_fifteen",        limit: 24
    t.integer "cpu_user",            limit: 4
    t.integer "cpu_system",          limit: 4
    t.integer "cpu_busy",            limit: 4
    t.integer "cpu_wait",            limit: 4
    t.float   "io_read",             limit: 24
    t.float   "io_write",            limit: 24
    t.integer "swap_used",           limit: 4
    t.float   "swap_in",             limit: 24
    t.float   "swap_out",            limit: 24
    t.float   "interrups",           limit: 24
    t.float   "context_switches",    limit: 24
    t.float   "memory_taken",        limit: 24
    t.float   "disk_usage",          limit: 24
    t.integer "processes_waiting",   limit: 4
    t.integer "processes_iowaiting", limit: 4
    t.string  "granularity",         limit: 0
  end

  add_index "stats", ["comp_id"], name: "index_stats_on_comp_id", using: :btree
  add_index "stats", ["timestamp"], name: "index_stats_on_timestamp", using: :btree

  create_table "today", force: :cascade do |t|
    t.string "today", limit: 255
  end

end
