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

ActiveRecord::Schema.define(version: 20150623061409) do

  create_table "answers", force: :cascade do |t|
    t.integer  "question_id"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id"

  create_table "my_answers", force: :cascade do |t|
    t.integer  "user_poll_id"
    t.integer  "answer_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "question_id"
  end

  add_index "my_answers", ["answer_id"], name: "index_my_answers_on_answer_id"
  add_index "my_answers", ["question_id"], name: "index_my_answers_on_question_id"
  add_index "my_answers", ["user_poll_id"], name: "index_my_answers_on_user_poll_id"

  create_table "my_apps", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "app_id"
    t.string   "javascript_origins"
    t.string   "secret_key"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "my_apps", ["user_id"], name: "index_my_apps_on_user_id"

  create_table "my_polls", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "expires_at"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "my_polls", ["user_id"], name: "index_my_polls_on_user_id"

  create_table "questions", force: :cascade do |t|
    t.integer  "my_poll_id"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "questions", ["my_poll_id"], name: "index_questions_on_my_poll_id"

  create_table "tokens", force: :cascade do |t|
    t.datetime "expires_at"
    t.integer  "user_id"
    t.string   "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "my_app_id"
  end

  add_index "tokens", ["my_app_id"], name: "index_tokens_on_my_app_id"
  add_index "tokens", ["user_id"], name: "index_tokens_on_user_id"

  create_table "user_polls", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "my_poll_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_polls", ["my_poll_id"], name: "index_user_polls_on_my_poll_id"
  add_index "user_polls", ["user_id"], name: "index_user_polls_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
