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

ActiveRecord::Schema.define(version: 20141219112439) do

  create_table "administrations", force: true do |t|
    t.integer  "will_id"
    t.boolean  "accept_admin"
    t.boolean  "expanded_powers"
    t.boolean  "borrow_powers"
    t.boolean  "appoint_admin_powers"
    t.boolean  "buy_sell_powers"
    t.boolean  "liability_powers"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "administrations", ["will_id"], name: "index_administrations_on_will_id"

  create_table "cash_gifts", force: true do |t|
    t.integer  "will_id"
    t.string   "shared_to"
    t.string   "relationship"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "surname"
    t.string   "address_one"
    t.string   "address_two"
    t.string   "city"
    t.string   "county"
    t.string   "postcode"
    t.string   "country"
    t.string   "amount"
    t.string   "certain_age"
    t.string   "if_dead"
    t.string   "certain_age_if_dead"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "count"
  end

  add_index "cash_gifts", ["will_id"], name: "index_cash_gifts_on_will_id"

  create_table "charitable_donations", force: true do |t|
    t.integer  "will_id"
    t.boolean  "popular_charity"
    t.string   "popular_charity_name"
    t.string   "name"
    t.string   "registered_charity_number"
    t.string   "address_one"
    t.string   "address_two"
    t.string   "city"
    t.string   "county"
    t.string   "country"
    t.string   "postcode"
    t.string   "amount"
    t.text     "instruction"
    t.boolean  "allow_alternate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "count"
  end

  add_index "charitable_donations", ["will_id"], name: "index_charitable_donations_on_will_id"

  create_table "charity_details", force: true do |t|
    t.integer  "will_id"
    t.string   "name"
    t.string   "registered_charity_number"
    t.string   "address_one"
    t.string   "address_two"
    t.string   "city"
    t.string   "county"
    t.string   "country"
    t.string   "postcode"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "charity_residuary_id"
  end

  add_index "charity_details", ["will_id"], name: "index_charity_details_on_will_id"

  create_table "charity_permissions", force: true do |t|
    t.boolean  "permission"
    t.integer  "will_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "charity_permissions", ["will_id"], name: "index_charity_permissions_on_will_id"

  create_table "executors", force: true do |t|
    t.integer  "will_id"
    t.boolean  "notary_express"
    t.boolean  "first"
    t.boolean  "second"
    t.boolean  "third"
    t.boolean  "forth"
    t.boolean  "replacement_first"
    t.boolean  "replacement_second"
    t.boolean  "replacement_third"
    t.boolean  "replacement_forth"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "executors", ["will_id"], name: "index_executors_on_will_id"

  create_table "funerals", force: true do |t|
    t.integer  "will_id"
    t.string   "preference"
    t.text     "wishes"
    t.string   "donate_organs"
    t.text     "specific_organs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "funerals", ["will_id"], name: "index_funerals_on_will_id"

  create_table "general_details", force: true do |t|
    t.integer  "will_id"
    t.string   "relationship"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "surname"
    t.string   "address_one"
    t.string   "address_two"
    t.string   "city"
    t.string   "county"
    t.string   "postcode"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "testator_detail_id"
    t.integer  "partner_detail_id"
    t.integer  "first_executor_id"
    t.integer  "second_executor_id"
    t.integer  "third_executor_id"
    t.integer  "forth_executor_id"
    t.integer  "first_replacement_executor_id"
    t.integer  "second_replacement_executor_id"
    t.integer  "third_replacement_executor_id"
    t.integer  "forth_replacement_executor_id"
    t.integer  "first_guardian_id"
    t.integer  "second_guardian_id"
    t.integer  "third_guardian_id"
    t.integer  "forth_guardian_id"
    t.integer  "first_replacement_guardian_id"
    t.integer  "second_replacement_guardian_id"
    t.integer  "third_replacement_guardian_id"
    t.integer  "forth_replacement_guardian_id"
    t.integer  "benificiary_id"
    t.integer  "second_benificiary_id"
    t.integer  "third_benificiary_id"
    t.integer  "forth_benificiary_id"
    t.integer  "replacement_benificiary_id"
    t.integer  "second_replacement_benificiary_id"
    t.integer  "third_replacement_benificiary_id"
    t.integer  "forth_replacement_benificiary_id"
    t.integer  "individual_residuary_id"
    t.integer  "charity_residuary_id"
  end

  add_index "general_details", ["partner_detail_id"], name: "index_general_details_on_partner_detail_id"
  add_index "general_details", ["testator_detail_id"], name: "index_general_details_on_testator_detail_id"
  add_index "general_details", ["will_id"], name: "index_general_details_on_will_id"

  create_table "guardians", force: true do |t|
    t.integer  "will_id"
    t.boolean  "appoint_future_guardians"
    t.boolean  "appoint_current_guardians"
    t.boolean  "second_guardian"
    t.boolean  "third_guardian"
    t.boolean  "forth_guardian"
    t.boolean  "replacement_guardian"
    t.boolean  "replacement_second_guardian"
    t.boolean  "replacement_third_guardian"
    t.boolean  "replacement_forth_guardian"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "guardians", ["will_id"], name: "index_guardians_on_will_id"

  create_table "partner_details", force: true do |t|
    t.integer  "will_id"
    t.string   "phone_no"
    t.string   "gender"
    t.string   "dob"
    t.string   "domicile_country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "partner_details", ["will_id"], name: "index_partner_details_on_will_id"

  create_table "personal_gifts", force: true do |t|
    t.string   "relationship"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "surname"
    t.string   "address_one"
    t.string   "address_two"
    t.string   "city"
    t.string   "county"
    t.string   "postcode"
    t.string   "country"
    t.integer  "will_id"
    t.text     "description"
    t.boolean  "as_cash_if_sold"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "count"
  end

  add_index "personal_gifts", ["will_id"], name: "index_personal_gifts_on_will_id"

  create_table "properties", force: true do |t|
    t.integer  "will_id"
    t.string   "land_reg_number"
    t.string   "address_one"
    t.string   "address_two"
    t.string   "city"
    t.string   "county"
    t.string   "country"
    t.string   "postcode"
    t.boolean  "sole_residence"
    t.integer  "recipient_no"
    t.string   "joint_or_common"
    t.boolean  "responsible_for_charges"
    t.boolean  "as_cash_if_sold"
    t.boolean  "held_in_trust"
    t.integer  "life_beneficiary_no"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "count"
    t.boolean  "complete",                default: false
  end

  add_index "properties", ["will_id"], name: "index_properties_on_will_id"

  create_table "questions", force: true do |t|
    t.string   "number"
    t.text     "question"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requests", force: true do |t|
    t.integer  "will_id"
    t.boolean  "requests"
    t.text     "specific"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "requests", ["will_id"], name: "index_requests_on_will_id"

  create_table "residuaries", force: true do |t|
    t.integer  "will_id"
    t.string   "amount_allowed_to_distribute"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "residuaries", ["will_id"], name: "index_residuaries_on_will_id"

  create_table "residuary_details", force: true do |t|
    t.integer  "will_id"
    t.string   "residuary_type"
    t.string   "share"
    t.string   "certain_age"
    t.string   "if_dead"
    t.string   "if_dead_certain_age"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "count"
    t.boolean  "secondary",           default: false
    t.boolean  "complete",            default: false
  end

  add_index "residuary_details", ["will_id"], name: "index_residuary_details_on_will_id"

  create_table "testator_details", force: true do |t|
    t.integer  "will_id"
    t.boolean  "consent"
    t.string   "phone_no"
    t.string   "gender"
    t.string   "dob"
    t.string   "domicile_country"
    t.string   "children"
    t.boolean  "children_age"
    t.boolean  "planning_marrige"
    t.boolean  "effective_post_marrige"
    t.boolean  "effective_post_death_sans_marrige"
    t.boolean  "tax_responsibility"
    t.string   "mirror_will"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "testator_details", ["will_id"], name: "index_testator_details_on_will_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wills", force: true do |t|
    t.string   "title"
    t.string   "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "complete",   default: false
    t.boolean  "term"
    t.integer  "progress",   default: 0
  end

end
