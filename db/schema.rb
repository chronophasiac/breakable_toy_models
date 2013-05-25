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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130525155533) do

  create_table "answers", :force => true do |t|
    t.integer  "start_position", :null => false
    t.integer  "end_position",   :null => false
    t.integer  "card_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "assignments", :force => true do |t|
    t.string   "title",           :null => false
    t.text     "instructions",    :null => false
    t.string   "url"
    t.string   "assignment_type", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "card_submission_logs", :force => true do |t|
    t.boolean  "answer_correct",     :null => false
    t.integer  "rated_difficulty"
    t.integer  "time_taken",         :null => false
    t.integer  "card_submission_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "card_submissions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "card_id"
    t.boolean  "helpful"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cards", :force => true do |t|
    t.string   "title",        :null => false
    t.text     "instructions", :null => false
    t.text     "problem",      :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "challenges", :force => true do |t|
    t.string   "title",      :null => false
    t.integer  "position",   :null => false
    t.integer  "lesson_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "lessons", :force => true do |t|
    t.string   "title",      :null => false
    t.text     "summary",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  add_foreign_key "answers", "cards", :name => "answers_card_id_fk"

  add_foreign_key "card_submission_logs", "card_submissions", :name => "card_submission_logs_card_submission_id_fk"

  add_foreign_key "card_submissions", "cards", :name => "card_submissions_card_id_fk"
  add_foreign_key "card_submissions", "users", :name => "card_submissions_user_id_fk"

  add_foreign_key "challenges", "lessons", :name => "challenges_lesson_id_fk"

end
