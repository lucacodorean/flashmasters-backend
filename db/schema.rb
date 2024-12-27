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

ActiveRecord::Schema[7.1].define(version: 2024_12_27_122045) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "bundles", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "key"
    t.integer "price"
    t.string "price_id"
    t.string "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "icon"
    t.integer "hours"
  end

  create_table "bundles_questions", force: :cascade do |t|
    t.bigint "bundle_id"
    t.bigint "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bundle_id"], name: "index_bundles_questions_on_bundle_id"
    t.index ["question_id"], name: "index_bundles_questions_on_question_id"
  end

  create_table "bundles_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "bundle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bundle_id"], name: "index_bundles_users_on_bundle_id"
    t.index ["user_id"], name: "index_bundles_users_on_user_id"
  end

  create_table "cards", force: :cascade do |t|
    t.string "text"
    t.string "key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cards_questions", force: :cascade do |t|
    t.bigint "card_id"
    t.bigint "question_id"
    t.index ["card_id"], name: "index_cards_questions_on_card_id"
    t.index ["question_id"], name: "index_cards_questions_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "text"
    t.integer "correct"
    t.jsonb "answers", default: {}
    t.string "key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin"
    t.bigint "role_id", null: false
    t.string "customer_id"
    t.string "description"
    t.string "icon"
    t.string "uid"
    t.string "provider"
    t.string "avatar"
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bundles_questions", "bundles"
  add_foreign_key "bundles_questions", "questions"
  add_foreign_key "bundles_users", "bundles"
  add_foreign_key "bundles_users", "users"
  add_foreign_key "cards_questions", "cards"
  add_foreign_key "cards_questions", "questions"
  add_foreign_key "users", "roles"
end
