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

ActiveRecord::Schema.define(version: 20180129172511) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "product_websites", force: :cascade do |t|
    t.string "website_url"
    t.string "price_xpath"
    t.string "sale_price_xpath"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title_xpath"
    t.string "image_xpath"
    t.boolean "price_ajax", default: false
  end

  create_table "products", force: :cascade do |t|
    t.string "product_url"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "price"
    t.string "name"
    t.string "sale_price"
    t.string "image_url"
    t.bigint "product_website_id"
    t.index ["product_website_id"], name: "index_products_on_product_website_id"
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
  end

  add_foreign_key "products", "product_websites"
end
