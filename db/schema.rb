# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100912093128) do

  create_table "country_teams", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "focus_groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "keywords", :force => true do |t|
    t.integer  "publication_id"
    t.integer  "variable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "languages", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "populations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "publication_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "publications", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "language_id"
    t.integer  "publication_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
    t.string   "access_state"
    t.integer  "user_id"
  end

  create_table "surveys", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",              :default => "", :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.integer  "login_count",        :default => 0,  :null => false
    t.integer  "failed_login_count", :default => 0,  :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "last_login_ip"
    t.string   "perishable_token",   :default => "", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "roles_mask"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"

  create_table "variables", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
