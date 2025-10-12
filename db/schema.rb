# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_10_11_133724) do
  create_table "boards", charset: "utf8mb4", force: :cascade do |t|
    t.string "title", null: false
    t.text "body", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "board_image"
    t.index ["user_id"], name: "index_boards_on_user_id"
  end

  create_table "bookmarks", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "board_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_bookmarks_on_board_id"
    t.index ["user_id", "board_id"], name: "index_bookmarks_on_user_id_and_board_id", unique: true
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "choices", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "question_id"
    t.string "choice_content", null: false
    t.integer "score", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_choices_on_question_id"
  end

  create_table "comments", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "board_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_comments_on_board_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "diagnoses", charset: "utf8mb4", force: :cascade do |t|
    t.string "question1", null: false
    t.string "question2", null: false
    t.string "question3", null: false
    t.string "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "diagnosis_answers", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "diagnosis_record_id"
    t.bigint "question_id"
    t.bigint "choice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["choice_id"], name: "index_diagnosis_answers_on_choice_id"
    t.index ["diagnosis_record_id"], name: "index_diagnosis_answers_on_diagnosis_record_id"
    t.index ["question_id"], name: "index_diagnosis_answers_on_question_id"
  end

  create_table "diagnosis_records", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "body_score", null: false
    t.integer "emotion_score", null: false
    t.integer "mind_score", null: false
    t.bigint "diagnosis_result_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diagnosis_result_id"], name: "index_diagnosis_records_on_diagnosis_result_id"
    t.index ["user_id"], name: "index_diagnosis_records_on_user_id"
  end

  create_table "diagnosis_results", charset: "utf8mb4", force: :cascade do |t|
    t.string "pattern_code", null: false
    t.string "result_summary", null: false
    t.text "suggestion", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "board_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_likes_on_board_id"
    t.index ["user_id", "board_id"], name: "index_likes_on_user_id_and_board_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "questions", charset: "utf8mb4", force: :cascade do |t|
    t.integer "fatigue_category", null: false
    t.string "question_content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "name", null: false
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "boards", "users"
  add_foreign_key "bookmarks", "boards"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "choices", "questions"
  add_foreign_key "comments", "boards"
  add_foreign_key "comments", "users"
  add_foreign_key "diagnosis_answers", "choices"
  add_foreign_key "diagnosis_answers", "diagnosis_records"
  add_foreign_key "diagnosis_answers", "questions"
  add_foreign_key "diagnosis_records", "diagnosis_results"
  add_foreign_key "diagnosis_records", "users"
  add_foreign_key "likes", "boards"
  add_foreign_key "likes", "users"
end
