# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_30_025041) do

  create_table "authors", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "author_img_file_name"
    t.string "author_img_content_type"
    t.bigint "author_img_file_size"
    t.datetime "author_img_updated_at"
  end

  create_table "bookcategories", force: :cascade do |t|
    t.integer "book_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id", "category_id"], name: "index_bookcategories_on_book_id_and_category_id", unique: true
    t.index ["book_id"], name: "index_bookcategories_on_book_id"
    t.index ["category_id"], name: "index_bookcategories_on_category_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "name"
    t.integer "quantity"
    t.string "publisher"
    t.integer "page"
    t.float "point"
    t.string "content"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "book_img_file_name"
    t.string "book_img_content_type"
    t.bigint "book_img_file_size"
    t.datetime "book_img_updated_at"
    t.index ["author_id"], name: "index_books_on_author_id"
  end

  create_table "carts", force: :cascade do |t|
    t.integer "verify", default: 3
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "requests", force: :cascade do |t|
    t.integer "number"
    t.datetime "datefrom"
    t.datetime "dateto"
    t.integer "cart_id"
    t.integer "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_requests_on_book_id"
    t.index ["cart_id"], name: "index_requests_on_cart_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating"
    t.text "comment"
    t.integer "user_id"
    t.integer "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_reviews_on_book_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.integer "role", default: 2
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "string"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bookcategories", "books"
  add_foreign_key "bookcategories", "categories"
  add_foreign_key "books", "authors"
  add_foreign_key "carts", "users"
  add_foreign_key "requests", "books"
  add_foreign_key "requests", "carts"
  add_foreign_key "reviews", "books"
  add_foreign_key "reviews", "users"
end
