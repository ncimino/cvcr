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

ActiveRecord::Schema.define(:version => 20140628200649) do

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

  create_table "admin_users", :force => true do |t|
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
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "carts", :force => true do |t|
    t.datetime "purchased_at"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "image_handlers", :force => true do |t|
    t.string   "title"
    t.string   "alt"
    t.string   "image"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "description"
    t.string   "button_text"
    t.string   "button_url"
    t.string   "link"
  end

  create_table "image_handlers_pages", :id => false, :force => true do |t|
    t.integer "page_id"
    t.integer "image_handler_id"
  end

  add_index "image_handlers_pages", ["image_handler_id", "page_id"], :name => "index_image_handlers_pages_on_image_handler_id_and_page_id", :unique => true
  add_index "image_handlers_pages", ["page_id"], :name => "index_image_handlers_pages_on_page_id"

  create_table "image_handlers_products", :id => false, :force => true do |t|
    t.integer "product_id"
    t.integer "image_handler_id"
  end

  add_index "image_handlers_products", ["image_handler_id", "product_id"], :name => "index_image_handlers_products_on_image_handler_id_and_product_id", :unique => true
  add_index "image_handlers_products", ["product_id"], :name => "index_image_handlers_products_on_product_id"

  create_table "line_items", :force => true do |t|
    t.decimal  "unit_price", :precision => 10, :scale => 2
    t.integer  "product_id"
    t.integer  "cart_id"
    t.integer  "quantity"
    t.datetime "created_at",                                                          :null => false
    t.datetime "updated_at",                                                          :null => false
    t.string   "grind",                                     :default => "Whole Bean"
  end

  create_table "main_areas", :force => true do |t|
    t.string  "title"
    t.string  "area_name"
    t.string  "link"
    t.integer "ordinal"
  end

  create_table "main_areas_sections", :id => false, :force => true do |t|
    t.integer "main_area_id"
    t.integer "section_id"
  end

  add_index "main_areas_sections", ["main_area_id"], :name => "index_main_areas_sections_on_main_area_id"
  add_index "main_areas_sections", ["section_id", "main_area_id"], :name => "index_main_areas_sections_on_section_id_and_main_area_id", :unique => true

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.string   "location"
    t.text     "content"
    t.string   "url"
    t.integer  "ordinal"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "description"
  end

  create_table "pages_sections", :id => false, :force => true do |t|
    t.integer "page_id"
    t.integer "section_id"
  end

  add_index "pages_sections", ["page_id"], :name => "index_pages_sections_on_page_id"
  add_index "pages_sections", ["section_id", "page_id"], :name => "index_pages_sections_on_section_id_and_page_id", :unique => true

  create_table "parameters", :force => true do |t|
    t.string   "key"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "parameters", ["key"], :name => "index_parameters_on_key", :unique => true

  create_table "payment_notifications", :force => true do |t|
    t.text     "params"
    t.integer  "cart_id"
    t.string   "status"
    t.string   "transaction_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.decimal  "price",          :precision => 10, :scale => 2
    t.text     "description"
    t.string   "image"
    t.boolean  "active"
    t.datetime "created_at",                                                      :null => false
    t.datetime "updated_at",                                                      :null => false
    t.text     "content"
    t.boolean  "supports_grind",                                :default => true
  end

  add_index "products", ["active"], :name => "index_active_products"

  create_table "products_sections", :id => false, :force => true do |t|
    t.integer "product_id"
    t.integer "section_id"
  end

  add_index "products_sections", ["product_id"], :name => "index_products_sections_on_product_id"
  add_index "products_sections", ["section_id", "product_id"], :name => "index_products_sections_on_section_id_and_product_id", :unique => true

  create_table "sections", :force => true do |t|
    t.string  "title"
    t.string  "link"
    t.string  "location"
    t.integer "ordinal"
  end

  create_table "users", :force => true do |t|
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
    t.string   "username"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
