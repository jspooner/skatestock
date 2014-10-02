# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 0) do

  create_table "carts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.date     "purchased_at"
    t.float    "total_price"
  end

  create_table "descriptions", :force => true do |t|
    t.integer  "proof_id"
    t.integer  "master_id"
    t.string   "title"
    t.string   "description"
    t.string   "location"
    t.string   "obsticle"
    t.string   "trick"
    t.string   "gender"
    t.string   "people"
    t.boolean  "portrait"
    t.string   "age"
    t.string   "color"
    t.string   "state"
    t.string   "city"
    t.integer  "rider_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "image_shell_id"
  end

  create_table "image_shells", :force => true do |t|
    t.integer  "user_id"
    t.integer  "description_id"
    t.float    "private_base_price"
    t.float    "editorial_base_price",                                    :null => false
    t.float    "stock_base_price",                                        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "private_sale",                        :default => 0,      :null => false
    t.integer  "original_id"
    t.integer  "stock_id"
    t.integer  "editorial_id"
    t.string   "requires_release",     :limit => 5,   :default => "true"
    t.string   "state",                :limit => 200, :default => "new"
  end

  create_table "image_shells_invitations", :id => false, :force => true do |t|
    t.integer "image_shell_id"
    t.integer "invitation_id"
  end

  create_table "image_shells_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "rider_id"
    t.integer "image_shell_id"
  end

  create_table "images", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "product_type",       :default => "original"
    t.integer  "parent_id"
    t.integer  "owner_id"
    t.string   "content_type"
    t.string   "filename"
    t.string   "thumbnail"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.integer  "user_id"
    t.integer  "description_id"
    t.integer  "base_price"
    t.integer  "image_shell_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "invitations", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone",      :limit => 20
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
  end

  create_table "invitations_users", :id => false, :force => true do |t|
    t.integer "invitation_id"
    t.integer "user_id"
  end

  create_table "line_items", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "master_id"
    t.string   "use_duration_start"
    t.string   "use_industry"
    t.string   "sensitiveSubject"
    t.string   "use_territory"
    t.float    "price"
    t.integer  "price_usage_id"
    t.integer  "price_media_id"
    t.integer  "cart_id"
    t.integer  "image_id"
    t.integer  "image_shell_id",     :null => false
  end

  create_table "line_items_price_options", :id => false, :force => true do |t|
    t.integer "line_item_id"
    t.integer "price_option_id"
  end

  create_table "payment_notifications", :force => true do |t|
    t.text     "params"
    t.integer  "cart_id"
    t.string   "status"
    t.string   "transaction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "price_medias", :force => true do |t|
    t.string   "name"
    t.float    "price",                         :null => false
    t.integer  "percentage"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "price_usage_id"
    t.integer  "is_editorial",   :default => 1
  end

  create_table "price_option_names", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "price_options", :force => true do |t|
    t.string   "name"
    t.string   "option"
    t.float    "price",          :default => 0.0, :null => false
    t.integer  "price_media_id"
    t.integer  "percentage",     :default => 0,   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "price_usages", :force => true do |t|
    t.string   "name"
    t.float    "price",      :default => 0.0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_categories", :force => true do |t|
    t.string   "name"
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_categories_product_use_durations", :id => false, :force => true do |t|
    t.integer "product_category_id"
    t.integer "product_use_duration_id"
  end

  create_table "product_categories_product_use_placements", :id => false, :force => true do |t|
    t.integer "product_use_placement_id"
    t.integer "product_category_id"
  end

  create_table "product_categories_product_use_printruns", :id => false, :force => true do |t|
    t.integer "product_category_id"
    t.integer "product_use_printrun_id"
  end

  create_table "product_categories_product_use_sizes", :id => false, :force => true do |t|
    t.integer "product_category_id"
    t.integer "product_use_size_id"
  end

  create_table "product_types", :force => true do |t|
    t.string   "name"
    t.float    "percentage"
    t.integer  "product_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "price"
  end

  create_table "product_use_durations", :force => true do |t|
    t.string   "name"
    t.float    "percentage"
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_use_industries", :force => true do |t|
    t.string   "name"
    t.float    "percentage"
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_use_placements", :force => true do |t|
    t.string   "name"
    t.float    "percentage"
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_use_printruns", :force => true do |t|
    t.string   "name"
    t.float    "percentage"
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_use_sizes", :force => true do |t|
    t.string   "name"
    t.float    "percentage"
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requests", :force => true do |t|
    t.integer  "image_id"
    t.text     "message"
    t.string   "request_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "image_shell_id"
    t.integer  "updated_image_id"
    t.string   "state",            :default => "new", :null => false
    t.integer  "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "state",                                    :default => "passive"
    t.string   "my_group",                                 :default => "consumer"
    t.datetime "deleted_at"
    t.integer  "agreed",                                   :default => 0,          :null => false
    t.integer  "agreed_to_model_release",                  :default => 0
    t.string   "contact_address"
    t.string   "contact_city"
    t.string   "contact_state"
    t.string   "contact_zip",               :limit => 10
    t.string   "phone",                     :limit => 20
    t.string   "first_name",                :limit => 200
    t.string   "last_name",                 :limit => 200
    t.string   "job_title",                 :limit => 100
    t.string   "company_name",              :limit => 100
    t.string   "fax",                       :limit => 20
    t.string   "company_type",              :limit => 200
    t.string   "billing_address",           :limit => 200
    t.string   "billing_city",              :limit => 200
    t.string   "billing_state",             :limit => 200
    t.string   "billing_zip",               :limit => 20
  end

end
