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

ActiveRecord::Schema.define(:version => 20150529190035) do

  create_table "addr", :primary_key => "gid", :force => true do |t|
    t.integer "tlid",      :limit => 8
    t.string  "fromhn",    :limit => 12
    t.string  "tohn",      :limit => 12
    t.string  "side",      :limit => 1
    t.string  "zip",       :limit => 5
    t.string  "plus4",     :limit => 4
    t.string  "fromtyp",   :limit => 1
    t.string  "totyp",     :limit => 1
    t.integer "fromarmid"
    t.integer "toarmid"
    t.string  "arid",      :limit => 22
    t.string  "mtfcc",     :limit => 5
    t.string  "statefp",   :limit => 2
  end

  add_index "addr", ["tlid", "statefp"], :name => "idx_tiger_addr_tlid_statefp"
  add_index "addr", ["zip"], :name => "idx_tiger_addr_zip"

# Could not dump table "addrfeat" because of following StandardError
#   Unknown type 'geometry' for column 'the_geom'

# Could not dump table "bg" because of following StandardError
#   Unknown type 'geometry' for column 'the_geom'

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "like",         :default => 0
    t.integer  "post_id"
    t.integer  "parent_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "dislike",      :default => 0
    t.boolean  "is_anonymous", :default => false
  end

  add_index "comments", ["post_id"], :name => "index_comments_on_post_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

# Could not dump table "county" because of following StandardError
#   Unknown type 'geometry' for column 'the_geom'

  create_table "county_lookup", :id => false, :force => true do |t|
    t.integer "st_code",               :null => false
    t.string  "state",   :limit => 2
    t.integer "co_code",               :null => false
    t.string  "name",    :limit => 90
  end

  add_index "county_lookup", ["state"], :name => "county_lookup_state_idx"

  create_table "countysub_lookup", :id => false, :force => true do |t|
    t.integer "st_code",               :null => false
    t.string  "state",   :limit => 2
    t.integer "co_code",               :null => false
    t.string  "county",  :limit => 90
    t.integer "cs_code",               :null => false
    t.string  "name",    :limit => 90
  end

  add_index "countysub_lookup", ["state"], :name => "countysub_lookup_state_idx"

# Could not dump table "cousub" because of following StandardError
#   Unknown type 'geometry' for column 'the_geom'

  create_table "dictionaries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "direction_lookup", :id => false, :force => true do |t|
    t.string "name",   :limit => 20, :null => false
    t.string "abbrev", :limit => 3
  end

  add_index "direction_lookup", ["abbrev"], :name => "direction_lookup_abbrev_idx"

# Could not dump table "edges" because of following StandardError
#   Unknown type 'geometry' for column 'the_geom'

  create_table "enums", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

# Could not dump table "faces" because of following StandardError
#   Unknown type 'geometry' for column 'the_geom'

  create_table "featnames", :primary_key => "gid", :force => true do |t|
    t.integer "tlid",       :limit => 8
    t.string  "fullname",   :limit => 100
    t.string  "name",       :limit => 100
    t.string  "predirabrv", :limit => 15
    t.string  "pretypabrv", :limit => 50
    t.string  "prequalabr", :limit => 15
    t.string  "sufdirabrv", :limit => 15
    t.string  "suftypabrv", :limit => 50
    t.string  "sufqualabr", :limit => 15
    t.string  "predir",     :limit => 2
    t.string  "pretyp",     :limit => 3
    t.string  "prequal",    :limit => 2
    t.string  "sufdir",     :limit => 2
    t.string  "suftyp",     :limit => 3
    t.string  "sufqual",    :limit => 2
    t.string  "linearid",   :limit => 22
    t.string  "mtfcc",      :limit => 5
    t.string  "paflag",     :limit => 1
    t.string  "statefp",    :limit => 2
  end

  add_index "featnames", ["tlid", "statefp"], :name => "idx_tiger_featnames_tlid_statefp"

  create_table "geocode_settings", :id => false, :force => true do |t|
    t.text "name",       :null => false
    t.text "setting"
    t.text "unit"
    t.text "category"
    t.text "short_desc"
  end

  create_table "loader_lookuptables", :id => false, :force => true do |t|
    t.integer "process_order",                        :default => 1000,  :null => false
    t.text    "lookup_name",                                             :null => false
    t.text    "table_name"
    t.boolean "single_mode",                          :default => true,  :null => false
    t.boolean "load",                                 :default => true,  :null => false
    t.boolean "level_county",                         :default => false, :null => false
    t.boolean "level_state",                          :default => false, :null => false
    t.boolean "level_nation",                         :default => false, :null => false
    t.text    "post_load_process"
    t.boolean "single_geom_mode",                     :default => false
    t.string  "insert_mode",           :limit => 1,   :default => "c",   :null => false
    t.text    "pre_load_process"
    t.string  "columns_exclude",       :limit => nil
    t.text    "website_root_override"
  end

  create_table "loader_platform", :id => false, :force => true do |t|
    t.string "os",                     :limit => 50, :null => false
    t.text   "declare_sect"
    t.text   "pgbin"
    t.text   "wget"
    t.text   "unzip_command"
    t.text   "psql"
    t.text   "path_sep"
    t.text   "loader"
    t.text   "environ_set_command"
    t.text   "county_process_command"
  end

  create_table "loader_variables", :id => false, :force => true do |t|
    t.string "tiger_year",     :limit => 4, :null => false
    t.text   "website_root"
    t.text   "staging_fold"
    t.text   "data_schema"
    t.text   "staging_schema"
  end

  create_table "location_service_google_place_types", :id => false, :force => true do |t|
    t.integer "id",   :null => false
    t.string  "name"
  end

  create_table "location_service_google_places_google_place_types", :id => false, :force => true do |t|
    t.integer "google_place_id"
    t.integer "google_place_type_id"
  end

  create_table "location_service_group_localities", :id => false, :force => true do |t|
    t.integer "group_id"
    t.integer "locality_id"
  end

  create_table "location_service_streets", :id => false, :force => true do |t|
    t.integer  "id",                        :null => false
    t.text     "name"
    t.integer  "status_id",  :default => 2
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "pagc_gaz", :force => true do |t|
    t.integer "seq"
    t.text    "word"
    t.text    "stdword"
    t.integer "token"
    t.boolean "is_custom", :default => true, :null => false
  end

  create_table "pagc_lex", :force => true do |t|
    t.integer "seq"
    t.text    "word"
    t.text    "stdword"
    t.integer "token"
    t.boolean "is_custom", :default => true, :null => false
  end

  create_table "pagc_rules", :force => true do |t|
    t.text    "rule"
    t.boolean "is_custom", :default => true
  end

# Could not dump table "place" because of following StandardError
#   Unknown type 'geometry' for column 'the_geom'

  create_table "place_lookup", :id => false, :force => true do |t|
    t.integer "st_code",               :null => false
    t.string  "state",   :limit => 2
    t.integer "pl_code",               :null => false
    t.string  "name",    :limit => 90
  end

  add_index "place_lookup", ["state"], :name => "place_lookup_state_idx"

  create_table "posts", :force => true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "like",         :default => 0
    t.integer  "type"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "dislike",      :default => 0
    t.boolean  "is_anonymous", :default => false
  end

  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "secondary_unit_lookup", :id => false, :force => true do |t|
    t.string "name",   :limit => 20, :null => false
    t.string "abbrev", :limit => 5
  end

  add_index "secondary_unit_lookup", ["abbrev"], :name => "secondary_unit_lookup_abbrev_idx"

  create_table "spatial_ref_sys", :id => false, :force => true do |t|
    t.integer "srid",                      :null => false
    t.string  "auth_name", :limit => 256
    t.integer "auth_srid"
    t.string  "srtext",    :limit => 2048
    t.string  "proj4text", :limit => 2048
  end

# Could not dump table "state" because of following StandardError
#   Unknown type 'geometry' for column 'the_geom'

  create_table "state_lookup", :id => false, :force => true do |t|
    t.integer "st_code",               :null => false
    t.string  "name",    :limit => 40
    t.string  "abbrev",  :limit => 3
    t.string  "statefp", :limit => 2
  end

  add_index "state_lookup", ["abbrev"], :name => "state_lookup_abbrev_key", :unique => true
  add_index "state_lookup", ["name"], :name => "state_lookup_name_key", :unique => true
  add_index "state_lookup", ["statefp"], :name => "state_lookup_statefp_key", :unique => true

  create_table "street_type_lookup", :id => false, :force => true do |t|
    t.string  "name",   :limit => 50,                    :null => false
    t.string  "abbrev", :limit => 50
    t.boolean "is_hw",                :default => false, :null => false
  end

  add_index "street_type_lookup", ["abbrev"], :name => "street_type_lookup_abbrev_idx"

# Could not dump table "tabblock" because of following StandardError
#   Unknown type 'geometry' for column 'the_geom'

  create_table "testmodels", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

# Could not dump table "tract" because of following StandardError
#   Unknown type 'geometry' for column 'the_geom'

  create_table "user_service_android_releases", :id => false, :force => true do |t|
    t.integer  "id",                                   :null => false
    t.string   "version",                              :null => false
    t.integer  "numerical_version",                    :null => false
    t.boolean  "is_deprecated",     :default => false
    t.text     "features_added"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  create_table "user_service_apps", :id => false, :force => true do |t|
    t.integer  "id",                                 :null => false
    t.string   "name"
    t.integer  "facebook_app_id"
    t.integer  "google_app_id"
    t.text     "api_public_key"
    t.text     "api_private_key"
    t.integer  "query_limit_per_day"
    t.integer  "status",              :default => 2
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "project_id"
    t.integer  "custom_provider_id"
  end

  create_table "user_service_campaigns", :id => false, :force => true do |t|
    t.integer  "id",         :null => false
    t.string   "name",       :null => false
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "project_id"
  end

  create_table "user_service_contact_numbers", :id => false, :force => true do |t|
    t.integer  "id",                                       :null => false
    t.integer  "number_type"
    t.string   "extension"
    t.string   "number"
    t.integer  "user_id"
    t.integer  "status",                    :default => 6
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "validation_window_ends_at"
  end

  create_table "user_service_custom_providers", :id => false, :force => true do |t|
    t.integer "id",   :null => false
    t.string  "name"
  end

  create_table "user_service_employees", :id => false, :force => true do |t|
    t.integer  "id",                      :null => false
    t.integer  "user_id"
    t.string   "department_name"
    t.text     "about_me"
    t.date     "joined_on"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "order_management_number"
  end

  create_table "user_service_facebook_apps", :id => false, :force => true do |t|
    t.integer "id",         :null => false
    t.string  "name",       :null => false
    t.string  "app_id",     :null => false
    t.string  "app_secret", :null => false
  end

  create_table "user_service_facebook_friends", :id => false, :force => true do |t|
    t.integer "id",          :null => false
    t.integer "user_id",     :null => false
    t.string  "facebook_id", :null => false
  end

  create_table "user_service_friends", :id => false, :force => true do |t|
    t.integer "user1_id", :null => false
    t.integer "user2_id", :null => false
  end

  create_table "user_service_gcm_users", :id => false, :force => true do |t|
    t.integer  "id",         :null => false
    t.integer  "user_id",    :null => false
    t.string   "gcm_reg_id"
    t.integer  "app_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_service_google_apps", :id => false, :force => true do |t|
    t.integer "id",                                                        :null => false
    t.string  "name",                                                      :null => false
    t.string  "client_id",                                                 :null => false
    t.string  "client_secret",                                             :null => false
    t.string  "scope",                                                     :null => false
    t.string  "response_type", :default => "code token id_token gsession"
    t.string  "api_key",                                                   :null => false
    t.string  "redirect_uri"
    t.string  "version"
  end

  create_table "user_service_leads", :id => false, :force => true do |t|
    t.integer  "id",          :null => false
    t.integer  "user_id"
    t.string   "source"
    t.text     "params"
    t.integer  "campaign_id"
    t.datetime "created_at"
  end

  create_table "user_service_permissions", :id => false, :force => true do |t|
    t.integer  "id",         :null => false
    t.integer  "role_id"
    t.string   "label"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_service_projects", :id => false, :force => true do |t|
    t.integer  "id",         :null => false
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_service_roles", :id => false, :force => true do |t|
    t.integer  "id",                         :null => false
    t.string   "name"
    t.integer  "status",      :default => 2
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.text     "description"
  end

  create_table "user_service_sms_logins", :id => false, :force => true do |t|
    t.integer  "id",                                :null => false
    t.string   "email",                             :null => false
    t.string   "number",                            :null => false
    t.string   "name",                              :null => false
    t.string   "device_id",                         :null => false
    t.string   "pre_token"
    t.string   "post_token"
    t.integer  "number_of_sms_sent", :default => 0
    t.datetime "last_sms_sent_at"
    t.integer  "status",             :default => 2
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "app_version"
    t.integer  "user_id"
    t.integer  "platform"
    t.string   "device_type"
  end

  create_table "user_service_unverified_card_tokens", :id => false, :force => true do |t|
    t.integer  "id",             :null => false
    t.string   "card_token",     :null => false
    t.string   "card_reference"
    t.integer  "sms_login_id",   :null => false
    t.integer  "user_id",        :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "user_service_user_providers", :id => false, :force => true do |t|
    t.integer  "id",                                     :null => false
    t.integer  "user_id",                                :null => false
    t.integer  "provider_id",                            :null => false
    t.string   "provider_type",                          :null => false
    t.string   "access_token"
    t.datetime "access_token_expires_at"
    t.string   "session_token"
    t.string   "password"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer  "sign_in_count",           :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "verify_token"
    t.datetime "verify_token_expires_at"
    t.integer  "status",                  :default => 3
    t.datetime "created_at"
  end

  create_table "user_service_users", :id => false, :force => true do |t|
    t.integer  "id",                             :null => false
    t.string   "email",                          :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.date     "date_of_birth"
    t.integer  "gender"
    t.string   "facebook_id"
    t.string   "google_id"
    t.integer  "status",          :default => 2
    t.string   "juspay_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "blacklist_count", :default => 0
  end

  create_table "user_service_users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "fb_link"
    t.integer  "department"
    t.integer  "anonymity_count", :default => 0
    t.string   "session_token"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "user_name"
  end

# Could not dump table "zcta5" because of following StandardError
#   Unknown type 'geometry' for column 'the_geom'

  create_table "zip_lookup", :id => false, :force => true do |t|
    t.integer "zip",                   :null => false
    t.integer "st_code"
    t.string  "state",   :limit => 2
    t.integer "co_code"
    t.string  "county",  :limit => 90
    t.integer "cs_code"
    t.string  "cousub",  :limit => 90
    t.integer "pl_code"
    t.string  "place",   :limit => 90
    t.integer "cnt"
  end

  create_table "zip_lookup_all", :id => false, :force => true do |t|
    t.integer "zip"
    t.integer "st_code"
    t.string  "state",   :limit => 2
    t.integer "co_code"
    t.string  "county",  :limit => 90
    t.integer "cs_code"
    t.string  "cousub",  :limit => 90
    t.integer "pl_code"
    t.string  "place",   :limit => 90
    t.integer "cnt"
  end

  create_table "zip_lookup_base", :id => false, :force => true do |t|
    t.string "zip",     :limit => 5,  :null => false
    t.string "state",   :limit => 40
    t.string "county",  :limit => 90
    t.string "city",    :limit => 90
    t.string "statefp", :limit => 2
  end

  create_table "zip_state", :id => false, :force => true do |t|
    t.string "zip",     :limit => 5, :null => false
    t.string "stusps",  :limit => 2, :null => false
    t.string "statefp", :limit => 2
  end

  create_table "zip_state_loc", :id => false, :force => true do |t|
    t.string "zip",     :limit => 5,   :null => false
    t.string "stusps",  :limit => 2,   :null => false
    t.string "statefp", :limit => 2
    t.string "place",   :limit => 100, :null => false
  end

end
