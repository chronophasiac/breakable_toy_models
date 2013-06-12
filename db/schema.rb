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

ActiveRecord::Schema.define(:version => 20130610174505) do

  create_table "activities", :force => true do |t|
    t.integer  "lesson_id",        :null => false
    t.integer  "completable_id",   :null => false
    t.string   "completable_type", :null => false
    t.integer  "position",         :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "activities", ["position", "lesson_id"], :name => "index_activities_on_position_and_lesson_id", :unique => true

  create_table "assignment_ratings", :force => true do |t|
    t.integer  "user_id",                          :null => false
    t.integer  "assignment_id",                    :null => false
    t.boolean  "helpful",       :default => false, :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "assignment_ratings", ["assignment_id"], :name => "index_assignment_ratings_on_assignment_id"
  add_index "assignment_ratings", ["user_id"], :name => "index_assignment_ratings_on_user_id"

  create_table "assignments", :force => true do |t|
    t.string   "title",           :null => false
    t.text     "instructions",    :null => false
    t.string   "url"
    t.string   "assignment_type", :null => false
    t.text     "summary",         :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "card_prerequisites", :force => true do |t|
    t.integer  "card_id",       :null => false
    t.integer  "assignment_id", :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "card_prerequisites", ["assignment_id"], :name => "index_card_prerequisites_on_assignment_id"
  add_index "card_prerequisites", ["card_id"], :name => "index_card_prerequisites_on_card_id"

  create_table "card_submission_logs", :force => true do |t|
    t.boolean  "correct",            :default => false, :null => false
    t.integer  "rated_difficulty"
    t.integer  "time_taken",                            :null => false
    t.integer  "card_submission_id",                    :null => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  add_index "card_submission_logs", ["card_submission_id"], :name => "index_card_submission_logs_on_card_submission_id"

  create_table "card_submissions", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "card_id",    :null => false
    t.boolean  "helpful"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "card_submissions", ["card_id"], :name => "index_card_submissions_on_card_id"
  add_index "card_submissions", ["user_id"], :name => "index_card_submissions_on_user_id"

  create_table "cards", :force => true do |t|
    t.string   "title",         :null => false
    t.text     "instructions",  :null => false
    t.text     "problem",       :null => false
    t.string   "solution_type", :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "challenge_decks", :force => true do |t|
    t.integer  "challenge_id", :null => false
    t.integer  "card_id",      :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "challenge_decks", ["card_id"], :name => "index_challenge_decks_on_card_id"
  add_index "challenge_decks", ["challenge_id"], :name => "index_challenge_decks_on_challenge_id"

  create_table "challenge_progressions", :force => true do |t|
    t.integer  "user_id",                     :null => false
    t.integer  "challenge_id",                :null => false
    t.integer  "score",        :default => 0, :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "challenge_progressions", ["challenge_id"], :name => "index_challenge_progressions_on_challenge_id"
  add_index "challenge_progressions", ["user_id"], :name => "index_challenge_progressions_on_user_id"

  create_table "challenges", :force => true do |t|
    t.string   "title",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "courseworks", :force => true do |t|
    t.integer  "user_id",                          :null => false
    t.integer  "assignment_id",                    :null => false
    t.integer  "lesson_id",                        :null => false
    t.boolean  "completed",     :default => false, :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "courseworks", ["assignment_id"], :name => "index_courseworks_on_assignment_id"
  add_index "courseworks", ["lesson_id"], :name => "index_courseworks_on_lesson_id"
  add_index "courseworks", ["user_id"], :name => "index_courseworks_on_user_id"

  create_table "enrollments", :force => true do |t|
    t.integer  "user_id",          :null => false
    t.integer  "lesson_id",        :null => false
    t.datetime "last_accessed_at", :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "enrollments", ["lesson_id"], :name => "index_enrollments_on_lesson_id"
  add_index "enrollments", ["user_id"], :name => "index_enrollments_on_user_id"

  create_table "lessons", :force => true do |t|
    t.string   "title",      :null => false
    t.text     "summary",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "solution_positions", :force => true do |t|
    t.integer  "start_position", :null => false
    t.integer  "end_position",   :null => false
    t.integer  "card_id",        :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "solution_positions", ["card_id"], :name => "index_solution_positions_on_card_id"

  create_table "solution_strings", :force => true do |t|
    t.string   "regex",      :null => false
    t.integer  "card_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "solution_strings", ["card_id"], :name => "index_solution_strings_on_card_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",        :null => false
    t.string   "encrypted_password",     :default => "",        :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username"
    t.string   "role",                   :default => "student", :null => false
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  add_foreign_key "activities", "lessons", :name => "activities_lesson_id_fk"

  add_foreign_key "assignment_ratings", "assignments", :name => "assignment_ratings_assignment_id_fk"
  add_foreign_key "assignment_ratings", "users", :name => "assignment_ratings_user_id_fk"

  add_foreign_key "card_prerequisites", "assignments", :name => "card_prerequisites_assignment_id_fk"
  add_foreign_key "card_prerequisites", "cards", :name => "card_prerequisites_card_id_fk"

  add_foreign_key "card_submission_logs", "card_submissions", :name => "card_submission_logs_card_submission_id_fk"

  add_foreign_key "card_submissions", "cards", :name => "card_submissions_card_id_fk"
  add_foreign_key "card_submissions", "users", :name => "card_submissions_user_id_fk"

  add_foreign_key "challenge_decks", "cards", :name => "challenge_decks_card_id_fk"
  add_foreign_key "challenge_decks", "challenges", :name => "challenge_decks_challenge_id_fk"

  add_foreign_key "challenge_progressions", "challenges", :name => "challenge_progressions_challenge_id_fk"
  add_foreign_key "challenge_progressions", "users", :name => "challenge_progressions_user_id_fk"

  add_foreign_key "courseworks", "assignments", :name => "courseworks_assignment_id_fk"
  add_foreign_key "courseworks", "lessons", :name => "courseworks_lesson_id_fk"
  add_foreign_key "courseworks", "users", :name => "courseworks_user_id_fk"

  add_foreign_key "enrollments", "lessons", :name => "enrollments_lesson_id_fk"
  add_foreign_key "enrollments", "users", :name => "enrollments_user_id_fk"

  add_foreign_key "solution_positions", "cards", :name => "solution_positions_card_id_fk"

  add_foreign_key "solution_strings", "cards", :name => "solution_strings_card_id_fk"

end
