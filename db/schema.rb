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

ActiveRecord::Schema.define(:version => 20131203063213) do

  create_table "colleges", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", :force => true do |t|
    t.string   "semester",       :null => false
    t.integer  "total_students", :null => false
    t.integer  "school_id",      :null => false
    t.integer  "curriculum_id",  :null => false
    t.integer  "presurvey_id",   :null => false
    t.integer  "postsurvey_id",  :null => false
    t.integer  "active",         :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "course_id"
  end

  add_index "courses_users", ["course_id"], :name => "index_courses_users_on_course_id"
  add_index "courses_users", ["user_id", "course_id"], :name => "index_courses_users_on_user_id_and_course_id"
  add_index "courses_users", ["user_id"], :name => "index_courses_users_on_user_id"

  create_table "curriculums", :force => true do |t|
    t.string   "name"
    t.boolean  "published",  :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "efficacies", :force => true do |t|
    t.integer  "presurvey_id"
    t.integer  "postsurvey_id"
    t.integer  "efficacy_1"
    t.integer  "efficacy_2"
    t.integer  "efficacy_3"
    t.integer  "efficacy_4"
    t.integer  "efficacy_5"
    t.integer  "efficacy_6"
    t.integer  "efficacy_7"
    t.integer  "efficacy_8"
    t.integer  "efficacy_9"
    t.integer  "efficacy_10"
    t.integer  "number_students"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "food_journals", :force => true do |t|
    t.integer  "school_semester_id"
    t.string   "student_name"
    t.integer  "week_num"
    t.integer  "fruit"
    t.integer  "vegetable"
    t.integer  "sugary_drink"
    t.integer  "water"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pending_users", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "school_city"
    t.string   "school_name"
    t.string   "school_county"
    t.string   "semester_name"
    t.integer  "semester_year"
    t.string   "school_district"
  end

  add_index "pending_users", ["user_id"], :name => "index_pending_users_on_user_id", :unique => true

  create_table "postsurveys", :force => true do |t|
    t.integer  "curriculum_id"
    t.integer  "course_id"
    t.text     "data"
    t.text     "total"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "presurveys", :force => true do |t|
    t.integer  "curriculum_id"
    t.integer  "course_id"
    t.text     "data"
    t.text     "total"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.string "label"
  end

  create_table "questions", :force => true do |t|
    t.string   "name",        :null => false
    t.string   "qtype",       :null => false
    t.string   "msg"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "section_id"
  end

  create_table "reports", :force => true do |t|
    t.float    "delta"
    t.text     "strengths"
    t.text     "weaknesses"
    t.text     "competencies"
    t.string   "admin_message"
    t.string   "report_link"
    t.string   "semester"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "school_semesters", :force => true do |t|
    t.integer "school_id"
    t.string  "name"
    t.integer "year"
  end

  create_table "schools", :force => true do |t|
    t.string   "name"
    t.string   "city"
    t.string   "county"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "district"
  end

  create_table "sections", :force => true do |t|
    t.string   "name",          :null => false
    t.string   "objective"
    t.string   "stype",         :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "curriculum_id"
  end

  create_table "static_contents", :force => true do |t|
    t.integer  "report_id"
    t.text     "intro_title"
    t.text     "introduction"
    t.text     "objectives_title"
    t.text     "objectives"
    t.text     "eval_title"
    t.text     "strength_weakness_intro"
    t.text     "strength_intro"
    t.text     "weakness_intro"
    t.text     "comp_intro"
    t.text     "summary"
    t.text     "behavior_title"
    t.text     "behavior_intro"
    t.text     "slight_increase_header"
    t.text     "increase_header"
    t.text     "decrease_header"
    t.text     "comp_header"
    t.text     "slight_decrease_header"
    t.text     "summary_header"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.integer  "profile_id"
    t.integer  "school_semester_id"
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "pending"
    t.integer  "pending_school_id"
    t.string   "pending_semester"
    t.string   "profile"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "college_id"
  end

  add_index "users", ["pending"], :name => "index_users_on_pending"

end
