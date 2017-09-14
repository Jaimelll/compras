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

ActiveRecord::Schema.define(version: 20170914140205) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "activities", force: :cascade do |t|
    t.integer  "actividad"
    t.string   "tipo"
    t.string   "numero"
    t.date     "pfecha"
    t.date     "plan"
    t.integer  "moneda"
    t.float    "importe"
    t.string   "obs"
    t.integer  "phase_id"
    t.integer  "admin_user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.date     "inicial"
    t.index ["admin_user_id"], name: "index_activities_on_admin_user_id", using: :btree
    t.index ["phase_id"], name: "index_activities_on_phase_id", using: :btree
  end

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "contracts", force: :cascade do |t|
    t.string   "numero"
    t.date     "fecha"
    t.string   "descripcion"
    t.integer  "obac"
    t.string   "postor"
    t.integer  "proveedor"
    t.integer  "moneda"
    t.float    "adjudicado"
    t.float    "presupuestado"
    t.integer  "admin_user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "periodo"
    t.integer  "proceso"
    t.integer  "plazo"
    t.integer  "sele"
    t.index ["admin_user_id"], name: "index_contracts_on_admin_user_id", using: :btree
  end

  create_table "details", force: :cascade do |t|
    t.integer  "actividad"
    t.string   "tipo"
    t.string   "numero"
    t.date     "pfecha"
    t.float    "importe"
    t.string   "obs"
    t.integer  "admin_user_id"
    t.integer  "item_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "moneda"
    t.date     "plan"
    t.date     "inicial"
    t.index ["admin_user_id"], name: "index_details_on_admin_user_id", using: :btree
    t.index ["item_id"], name: "index_details_on_item_id", using: :btree
  end

  create_table "elements", force: :cascade do |t|
    t.integer  "actividad"
    t.string   "tipo"
    t.string   "numero"
    t.date     "pfecha"
    t.float    "importe"
    t.string   "obs"
    t.integer  "admin_user_id"
    t.integer  "contract_id"
    t.integer  "moneda"
    t.date     "plan"
    t.date     "inicial"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["admin_user_id"], name: "index_elements_on_admin_user_id", using: :btree
    t.index ["contract_id"], name: "index_elements_on_contract_id", using: :btree
  end

  create_table "employees", force: :cascade do |t|
    t.string   "dni"
    t.string   "ape_pat"
    t.string   "ape_mat"
    t.string   "nombres"
    t.string   "direccion"
    t.string   "telefono"
    t.string   "correo"
    t.date     "fec_nacimiento"
    t.integer  "estado"
    t.integer  "tip_tra"
    t.integer  "esta_civil"
    t.integer  "afp"
    t.integer  "admin_user_id"
    t.string   "foto"
    t.string   "ape_nom"
    t.string   "correo_corp"
    t.date     "fec_inicon"
    t.date     "fec_tercon"
    t.string   "grado"
    t.string   "cargo"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["admin_user_id"], name: "index_employees_on_admin_user_id", using: :btree
  end

  create_table "formulas", force: :cascade do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.integer  "orden"
    t.string   "obs"
    t.integer  "cantidad"
    t.integer  "admin_user_id"
    t.integer  "product_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "numero"
    t.integer  "acti"
    t.index ["admin_user_id"], name: "index_formulas_on_admin_user_id", using: :btree
    t.index ["product_id"], name: "index_formulas_on_product_id", using: :btree
  end

  create_table "items", force: :cascade do |t|
    t.string   "pac"
    t.integer  "obac"
    t.integer  "lista"
    t.integer  "ejecucion"
    t.integer  "modalidad"
    t.integer  "dependencia"
    t.integer  "tipo"
    t.string   "descripcion"
    t.integer  "cantidad"
    t.float    "certificado"
    t.integer  "fuente"
    t.integer  "admin_user_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "rubro"
    t.integer  "seleccion"
    t.date     "mesconvoca"
    t.integer  "cuadrante"
    t.integer  "periodo"
    t.string   "expediente"
    t.string   "observacion"
    t.integer  "exped",         default: 0
    t.integer  "exped2"
    t.date     "solicita"
    t.float    "ccp"
    t.float    "cpr"
    t.integer  "sele3"
    t.index ["admin_user_id"], name: "index_items_on_admin_user_id", using: :btree
  end

  create_table "packages", force: :cascade do |t|
    t.integer  "item"
    t.integer  "moneda"
    t.float    "adjudicado"
    t.float    "presupuestado"
    t.integer  "admin_user_id"
    t.integer  "contract_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["admin_user_id"], name: "index_packages_on_admin_user_id", using: :btree
    t.index ["contract_id"], name: "index_packages_on_contract_id", using: :btree
  end

  create_table "phases", force: :cascade do |t|
    t.string   "nomenclatura"
    t.string   "descripcion"
    t.integer  "moneda"
    t.float    "valor"
    t.integer  "admin_user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "expediente"
    t.integer  "periodo"
    t.date     "pp"
    t.integer  "sele"
    t.integer  "convocatoria"
    t.float    "sele2"
    t.index ["admin_user_id"], name: "index_phases_on_admin_user_id", using: :btree
  end

  create_table "pieces", force: :cascade do |t|
    t.string   "codigo"
    t.string   "descripcion"
    t.integer  "estado"
    t.integer  "moneda"
    t.float    "presupuestado"
    t.float    "referencial"
    t.float    "adjudicado"
    t.string   "postor"
    t.integer  "phase_id"
    t.integer  "admin_user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "cantidad"
    t.index ["admin_user_id"], name: "index_pieces_on_admin_user_id", using: :btree
    t.index ["phase_id"], name: "index_pieces_on_phase_id", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.integer  "orden"
    t.string   "obs"
    t.integer  "admin_user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["admin_user_id"], name: "index_products_on_admin_user_id", using: :btree
  end

  add_foreign_key "activities", "admin_users"
  add_foreign_key "activities", "phases"
  add_foreign_key "contracts", "admin_users"
  add_foreign_key "details", "admin_users"
  add_foreign_key "details", "items"
  add_foreign_key "elements", "admin_users"
  add_foreign_key "elements", "contracts"
  add_foreign_key "employees", "admin_users"
  add_foreign_key "formulas", "admin_users"
  add_foreign_key "formulas", "products"
  add_foreign_key "items", "admin_users"
  add_foreign_key "packages", "admin_users"
  add_foreign_key "packages", "contracts"
  add_foreign_key "phases", "admin_users"
  add_foreign_key "pieces", "admin_users"
  add_foreign_key "pieces", "phases"
  add_foreign_key "products", "admin_users"
end
