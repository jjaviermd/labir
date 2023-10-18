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

ActiveRecord::Schema[7.0].define(version: 2023_10_17_184240) do
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

  create_table "cases", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.bigint "pathologist_id", null: false
    t.integer "status", default: 1
    t.text "macro_description"
    t.text "micro_description"
    t.text "diagnosis"
    t.string "organ", null: false
    t.string "physician"
    t.string "speciality"
    t.string "protocol_number", null: false
    t.string "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "type_of_sample"
    t.index ["pathologist_id"], name: "index_cases_on_pathologist_id"
    t.index ["patient_id"], name: "index_cases_on_patient_id"
    t.index ["protocol_number"], name: "index_cases_on_protocol_number"
    t.index ["status"], name: "index_cases_on_status"
  end

  create_table "pathologists", force: :cascade do |t|
    t.string "last_name", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "registry_number", null: false
    t.index ["last_name"], name: "index_pathologists_on_last_name"
    t.index ["registry_number"], name: "index_pathologists_on_registry_number"
  end

  create_table "patients", force: :cascade do |t|
    t.string "dni"
    t.string "f_last_name", null: false
    t.string "l_last_name"
    t.string "name", null: false
    t.string "phone_number"
    t.string "email"
    t.string "insurance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "age"
    t.date "birth_day"
    t.integer "gender"
    t.index ["dni"], name: "index_patients_on_dni"
    t.index ["f_last_name"], name: "index_patients_on_f_last_name"
    t.index ["name"], name: "index_patients_on_name"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "cases", "pathologists"
  add_foreign_key "cases", "patients"
end
