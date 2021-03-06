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

ActiveRecord::Schema.define(version: 20160803222939) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "budgets", force: :cascade do |t|
    t.integer  "family_id",                                                         null: false
    t.string   "name"
    t.decimal  "amount",                precision: 12, scale: 2
    t.string   "mode",       limit: 32,                          default: "normal", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.string   "changed_by"
    t.index ["family_id"], name: "index_budgets_on_family_id", using: :btree
  end

  create_table "expenses", force: :cascade do |t|
    t.integer  "budget_id",                           null: false
    t.decimal  "amount",     precision: 12, scale: 2, null: false
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.string   "changed_by"
    t.index ["budget_id"], name: "index_expenses_on_budget_id", using: :btree
  end

  create_table "families", force: :cascade do |t|
    t.string  "name"
    t.integer "created_by"
    t.integer "updated_by"
    t.string  "changed_by"
    t.string  "currency",   default: "USD", null: false
    t.integer "timezone",   default: -4,    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "api_key"
    t.string   "facebook_token"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "family_id"
    t.string   "first_name",             default: "", null: false
    t.string   "last_name",              default: "", null: false
    t.integer  "created_by"
    t.integer  "updated_by"
    t.string   "changed_by"
    t.index ["api_key"], name: "index_users_on_api_key", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
