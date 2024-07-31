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

ActiveRecord::Schema.define(version: 2024_02_21_070131) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "activity_trackers", force: :cascade do |t|
    t.integer "created_by"
    t.string "headings"
    t.string "contents"
    t.string "app_url"
    t.boolean "is_read", default: false
    t.datetime "read_at"
    t.integer "user_id", null: false
    t.boolean "action_needed", default: false
    t.integer "guest_id"
    t.string "notification_type"
    t.integer "notification_type_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "announcements", force: :cascade do |t|
    t.string "type"
    t.string "title"
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
  end

  create_table "attendances", force: :cascade do |t|
    t.date "date"
    t.integer "present", default: [], array: true
    t.integer "leave", default: [], array: true
    t.integer "holiday", default: [], array: true
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "expert_id"
  end

  create_table "bank_details", force: :cascade do |t|
    t.integer "user_id"
    t.string "bank_name"
    t.string "account_number"
    t.string "ifsc_code"
    t.string "branch_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "approved", default: false
  end

  create_table "certificate_verifications", force: :cascade do |t|
    t.text "message"
    t.text "note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.integer "expert_id"
    t.string "status"
  end

  create_table "contact_details", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.string "email"
    t.string "mobile_number"
    t.string "relationship"
    t.string "type"
    t.text "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "gadgets", force: :cascade do |t|
    t.date "date"
    t.string "employee_id"
    t.string "designation"
    t.string "department"
    t.string "reporting_to"
    t.string "email_id"
    t.string "mobile_number"
    t.string "working_location"
    t.string "made_by"
    t.string "serial_number"
    t.string "model"
    t.string "color"
    t.boolean "charger"
    t.boolean "keyboard"
    t.boolean "mouse"
    t.boolean "bag"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "expert_id"
    t.integer "user_id"
  end

  create_table "hours_entries", force: :cascade do |t|
    t.integer "user_id"
    t.jsonb "weekly_status", default: "{}", null: false
    t.boolean "approval", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "week_start_date"
  end

  create_table "leave_banks", force: :cascade do |t|
    t.integer "user_id"
    t.string "year"
    t.string "casual_leaves"
    t.string "sick_leaves"
    t.string "other_leaves"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "expert_id"
  end

  create_table "leaves", force: :cascade do |t|
    t.integer "user_id"
    t.string "leave_purpose"
    t.string "start_date"
    t.string "end_date"
    t.string "type_of_leave"
    t.boolean "approval", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "number_of_leaves"
    t.integer "manager_id"
  end

  create_table "merits", force: :cascade do |t|
    t.string "merit_type"
    t.text "reason"
    t.integer "seviority"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "expert_id"
    t.string "company_email_id"
  end

  create_table "notification_devices", force: :cascade do |t|
    t.string "device_token"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "created_by"
    t.string "headings"
    t.string "contents"
    t.string "app_url"
    t.boolean "is_read", default: false
    t.datetime "read_at"
    t.integer "user_id", null: false
    t.boolean "action_needed", default: false
    t.integer "guest_id"
    t.string "notification_type"
    t.integer "notification_type_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "performance_appreciations", force: :cascade do |t|
    t.date "appreciation_date"
    t.text "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.integer "expert_id"
  end

  create_table "personal_details", force: :cascade do |t|
    t.integer "user_id"
    t.string "first_name"
    t.string "last_name"
    t.string "gender"
    t.string "nationality"
    t.string "marital_status"
    t.string "mobile_number"
    t.string "aadhar_card_number"
    t.string "pan_card_number"
    t.string "company_email"
    t.string "personal_email"
    t.text "present_address"
    t.text "permanent_address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "date_of_birth"
    t.string "profile_pic"
  end

  create_table "projects", force: :cascade do |t|
    t.integer "user_id"
    t.string "project_name"
    t.string "status"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "relieving_details", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.text "exit_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "expert_id"
  end

  create_table "schedules_and_events", force: :cascade do |t|
    t.string "event_name"
    t.date "event_date"
    t.string "venue"
    t.text "view"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.datetime "event_time"
  end

  create_table "skills", force: :cascade do |t|
    t.integer "user_id"
    t.string "skill_name"
    t.float "rating"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.integer "user_id"
    t.string "daily_status"
    t.string "task_name"
    t.string "task_progress"
    t.string "description"
    t.integer "worked_hours"
    t.integer "total_hours"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "taxes", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_projects", force: :cascade do |t|
    t.integer "user_id"
    t.integer "project_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "name"
    t.string "username"
    t.string "designation"
    t.string "employee_id_number"
    t.string "roles", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "date_of_joining"
    t.boolean "active", default: true
    t.boolean "notifications_allow", default: false
  end

  create_table "work_experiences", force: :cascade do |t|
    t.integer "user_id"
    t.string "organization_name"
    t.string "designation"
    t.string "date_of_join"
    t.string "date_of_end"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
