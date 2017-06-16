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

ActiveRecord::Schema.define(version: 20170616001824) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text "body", default: "", null: false
    t.bigint "user_id"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry"
    t.index ["ancestry"], name: "index_comments_on_ancestry"
    t.index ["course_id"], name: "index_comments_on_course_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "code"
    t.string "title"
    t.string "department"
    t.string "division"
    t.integer "level"
    t.string "campus"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code", "campus"], name: "index_courses_on_code_and_campus", unique: true
  end

  create_table "enrolments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "term_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lectures", force: :cascade do |t|
    t.bigint "term_id"
    t.string "code"
    t.string "instructor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["term_id"], name: "index_lectures_on_term_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "value", default: 0
    t.string "rating_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "term_id"
    t.index ["term_id"], name: "index_ratings_on_term_id"
    t.index ["user_id", "term_id", "rating_type"], name: "index_ratings_on_user_id_and_term_id_and_rating_type", unique: true
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "terms", force: :cascade do |t|
    t.bigint "course_id"
    t.string "term"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.text "exclusions"
    t.text "prerequisites"
    t.text "breadths"
    t.index ["course_id"], name: "index_terms_on_course_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.text "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "comments", "courses"
  add_foreign_key "comments", "users"
  add_foreign_key "lectures", "terms"
  add_foreign_key "ratings", "terms"
  add_foreign_key "ratings", "users"
  add_foreign_key "terms", "courses"
end
