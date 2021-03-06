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

ActiveRecord::Schema.define(version: 20170527033238) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'addresses', force: :cascade do |t|
    t.string 'primary_address', default: '', null: false
    t.string 'secondary_address'
    t.string 'number'
    t.string 'zip_code', default: '', null: false
    t.string 'city', default: '', null: false
    t.string 'state', default: '', null: false
    t.string 'country', default: '', null: false
    t.decimal 'latitude', precision: 10, scale: 6
    t.decimal 'longitude', precision: 10, scale: 6
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'user_id'
    t.index ['user_id'], name: 'index_addresses_on_user_id'
  end

  create_table 'competencies', force: :cascade do |t|
    t.bigint 'user_id'
    t.bigint 'skill_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['skill_id'], name: 'index_competencies_on_skill_id'
    t.index ['user_id'], name: 'index_competencies_on_user_id'
  end

  create_table 'skills', force: :cascade do |t|
    t.string 'name', default: '', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'first_name', default: '', null: false
    t.string 'last_name'
    t.string 'email', default: '', null: false
    t.string 'password_digest', default: '', null: false
    t.string 'cpf', default: '', null: false
    t.string 'phone', default: '', null: false
    t.integer 'gender', default: 2, null: false
    t.date 'birth_date', default: -> { "('now'::text)::date" }, null: false
    t.string 'confirmation_token'
    t.datetime 'confirmation_sent_at'
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.string 'unconfirmed_email'
    t.string 'authentication_token'
    t.boolean 'active', default: false, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'avatar_file_name'
    t.string 'avatar_content_type'
    t.integer 'avatar_file_size'
    t.datetime 'avatar_updated_at'
    t.index ['authentication_token'], name: 'index_users_on_authentication_token', unique: true
    t.index ['confirmation_token'], name: 'index_users_on_confirmation_token', unique: true
    t.index ['cpf'], name: 'index_users_on_cpf', unique: true
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['phone'], name: 'index_users_on_phone', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'addresses', 'users'
  add_foreign_key 'competencies', 'skills'
  add_foreign_key 'competencies', 'users'
end
