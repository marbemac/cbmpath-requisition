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

ActiveRecord::Schema.define(:version => 20130728213637) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "doctors", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "searchable_name"
    t.integer  "cbm_doctor_identifier"
  end

  add_index "doctors", ["searchable_name"], :name => "index_doctors_on_searchable_name"
  add_index "doctors", ["user_id"], :name => "index_doctors_on_user_id"

  create_table "patients", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_name"
    t.string   "sex"
    t.date     "date_of_birth"
    t.string   "ssn"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "insurance_type"
    t.string   "insurance_name"
    t.string   "insurance_insured_name"
    t.string   "insurance_group_number"
    t.date     "insurance_date_of_birth"
    t.string   "insurance_insured_employer"
    t.string   "insurance_relation"
    t.string   "insurance_policy_number"
    t.string   "insurance_phone"
    t.string   "insurance_insured_work_phone"
    t.integer  "user_id"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.string   "searchable_name"
    t.string   "insurance_address"
    t.string   "insurance_city"
    t.string   "insurance_state"
    t.string   "insurance_zipcode"
  end

  add_index "patients", ["searchable_name"], :name => "index_patients_on_searchable_name"
  add_index "patients", ["user_id"], :name => "index_patients_on_user_id"

  create_table "requisition_forms", :force => true do |t|
    t.integer  "doctor_id"
    t.integer  "doctor2_id"
    t.text     "icd9_codes"
    t.integer  "patient_id"
    t.integer  "user_id"
    t.text     "medical_history",                      :default => "{}"
    t.text     "special_requests"
    t.text     "specimens"
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at",                                             :null => false
    t.date     "collection_date"
    t.string   "form_type"
    t.text     "laboratory_tests",                     :default => "{}"
    t.text     "general_fields",                       :default => "{}"
    t.integer  "patient_req_id"
    t.integer  "doctor_req_id"
    t.integer  "doctor2_req_id"
    t.string   "patient_first_name"
    t.string   "patient_last_name"
    t.string   "patient_middle_name"
    t.string   "patient_sex"
    t.date     "patient_date_of_birth"
    t.string   "patient_ssn"
    t.string   "patient_address"
    t.string   "patient_city"
    t.string   "patient_state"
    t.string   "patient_zipcode"
    t.string   "patient_insurance_type"
    t.string   "patient_insurance_name"
    t.string   "patient_insurance_insured_name"
    t.string   "patient_insurance_group_number"
    t.date     "patient_insurance_date_of_birth"
    t.string   "patient_insurance_insured_employer"
    t.string   "patient_insurance_relation"
    t.string   "patient_insurance_policy_number"
    t.string   "patient_insurance_phone"
    t.string   "patient_insurance_insured_work_phone"
    t.string   "doctor_name"
    t.string   "doctor2_name"
    t.string   "patient_insurance_address"
    t.string   "patient_insurance_city"
    t.string   "patient_insurance_state"
    t.string   "patient_insurance_zipcode"
  end

  add_index "requisition_forms", ["doctor2_id"], :name => "index_requisition_forms_on_doctor2_id"
  add_index "requisition_forms", ["doctor2_req_id"], :name => "index_requisition_forms_on_doctor2_req_id"
  add_index "requisition_forms", ["doctor_id"], :name => "index_requisition_forms_on_doctor_id"
  add_index "requisition_forms", ["doctor_req_id"], :name => "index_requisition_forms_on_doctor_req_id"
  add_index "requisition_forms", ["patient_id"], :name => "index_requisition_forms_on_patient_id"
  add_index "requisition_forms", ["patient_req_id"], :name => "index_requisition_forms_on_patient_req_id"
  add_index "requisition_forms", ["user_id"], :name => "index_requisition_forms_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "practice_name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
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
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "cbm_user_identifier"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
