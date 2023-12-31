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

ActiveRecord::Schema[7.1].define(version: 2023_12_11_110547) do
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

  create_table "bookmarks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "demonstration_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["demonstration_id"], name: "index_bookmarks_on_demonstration_id"
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "demo_topics", force: :cascade do |t|
    t.bigint "demonstration_id", null: false
    t.bigint "topic_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["demonstration_id"], name: "index_demo_topics_on_demonstration_id"
    t.index ["topic_id"], name: "index_demo_topics_on_topic_id"
  end

  create_table "demo_types", force: :cascade do |t|
    t.bigint "demonstration_id", null: false
    t.bigint "type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["demonstration_id"], name: "index_demo_types_on_demonstration_id"
    t.index ["type_id"], name: "index_demo_types_on_type_id"
  end

  create_table "demonstrations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.text "description"
    t.string "location"
    t.string "postcode"
    t.string "city"
    t.string "country"
    t.float "latitude"
    t.float "longitude"
    t.datetime "start_time"
    t.datetime "end_time"
    t.text "extra_info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
    t.string "thema"
    t.index ["user_id"], name: "index_demonstrations_on_user_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
  end

  create_table "types", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
  end

  create_table "user_topics", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "topic_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["topic_id"], name: "index_user_topics_on_topic_id"
    t.index ["user_id"], name: "index_user_topics_on_user_id"
  end

  create_table "user_types", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type_id"], name: "index_user_types_on_type_id"
    t.index ["user_id"], name: "index_user_types_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bookmarks", "demonstrations"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "demo_topics", "demonstrations"
  add_foreign_key "demo_topics", "topics"
  add_foreign_key "demo_types", "demonstrations"
  add_foreign_key "demo_types", "types"
  add_foreign_key "demonstrations", "users"
  add_foreign_key "user_topics", "topics"
  add_foreign_key "user_topics", "users"
  add_foreign_key "user_types", "types"
  add_foreign_key "user_types", "users"
end
