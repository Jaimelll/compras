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

ActiveRecord::Schema.define(version: 20180511144545) do

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
    t.integer  "categoria",              default: 1,  null: false
    t.integer  "periodo",                default: 4,  null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "agreements", force: :cascade do |t|
    t.integer  "employee_id"
    t.integer  "num_cont"
    t.date     "fec_inicon"
    t.date     "fec_tercon"
    t.string   "puesto"
    t.integer  "cod_hor"
    t.float    "remuneracion"
    t.integer  "area"
    t.integer  "tipo_contra"
    t.date     "fec_retiro"
    t.string   "motivo_retir"
    t.string   "obs"
    t.integer  "admin_user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "contra"
    t.integer  "sele"
    t.index ["admin_user_id"], name: "index_agreements_on_admin_user_id", using: :btree
    t.index ["employee_id"], name: "index_agreements_on_employee_id", using: :btree
  end

  create_table "articles", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "ficha"
    t.string   "descripcion"
    t.integer  "unidad"
    t.float    "cantidad"
    t.string   "precision"
    t.string   "paquete"
    t.integer  "piece"
    t.float    "referencial"
    t.integer  "estado"
    t.string   "obs"
    t.integer  "art1"
    t.integer  "art2"
    t.string   "art3"
    t.float    "art4"
    t.integer  "admin_user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "art5"
    t.string   "art6"
    t.string   "art7"
    t.integer  "art8"
    t.index ["admin_user_id"], name: "index_articles_on_admin_user_id", using: :btree
    t.index ["item_id"], name: "index_articles_on_item_id", using: :btree
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
    t.integer  "area"
    t.integer  "sele"
    t.float    "remuneracion"
    t.integer  "sele2"
    t.string   "distrito"
    t.string   "anexo"
    t.string   "celular_corp"
    t.integer  "sele3"
    t.string   "obs"
    t.index ["admin_user_id"], name: "index_employees_on_admin_user_id", using: :btree
  end

  create_table "experiences", force: :cascade do |t|
    t.integer  "employee_id"
    t.string   "empresa"
    t.date     "desde"
    t.date     "hasta"
    t.string   "cargo"
    t.string   "obs"
    t.integer  "admin_user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["admin_user_id"], name: "index_experiences_on_admin_user_id", using: :btree
    t.index ["employee_id"], name: "index_experiences_on_employee_id", using: :btree
  end

  create_table "families", force: :cascade do |t|
    t.integer  "employee_id"
    t.integer  "tipo_rela"
    t.string   "ape_nom"
    t.date     "fec_nac"
    t.integer  "admin_user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["admin_user_id"], name: "index_families_on_admin_user_id", using: :btree
    t.index ["employee_id"], name: "index_families_on_employee_id", using: :btree
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
    t.integer  "dobac"
    t.integer  "dsexp"
    t.integer  "dcexp"
    t.integer  "ddc"
    t.integer  "ddem"
    t.integer  "ddpc"
    t.integer  "dfc"
    t.integer  "ddec"
    t.index ["admin_user_id"], name: "index_items_on_admin_user_id", using: :btree
  end

  create_table "lists", force: :cascade do |t|
    t.string   "clase"
    t.string   "descripcion"
    t.integer  "orden"
    t.integer  "admin_user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["admin_user_id"], name: "index_lists_on_admin_user_id", using: :btree
  end

  create_table "movements", force: :cascade do |t|
    t.date    "fechap"
    t.integer "estado"
    t.date    "creada"
    t.string  "observ"
    t.integer "sheet_id"
    t.integer "admin_user_id"
    t.string  "codigo"
    t.string  "descripcion"
    t.string  "sele1"
    t.integer "sele2"
    t.index ["admin_user_id"], name: "index_movements_on_admin_user_id", using: :btree
    t.index ["sheet_id"], name: "index_movements_on_sheet_id", using: :btree
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
    t.integer  "sele3"
    t.integer  "sele4"
    t.string   "proceso"
    t.string   "comite"
    t.string   "postores"
    t.string   "obs"
    t.integer  "sele5"
    t.float    "ep"
    t.float    "mgp"
    t.float    "fap"
    t.float    "ccffaa"
    t.integer  "convo"
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
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "cantidad"
    t.integer  "canti_dem"
    t.integer  "sele"
    t.integer  "prop_obac"
    t.integer  "invi_dem"
    t.integer  "invi_dpc"
    t.integer  "presenta"
    t.integer  "admitido"
    t.integer  "pasan"
    t.integer  "resulta"
    t.integer  "version"
    t.integer  "tipo_postor"
    t.string   "motivo"
    t.string   "proceso"
    t.float    "ep"
    t.float    "mgp"
    t.float    "fap"
    t.float    "ccffaa"
    t.float    "ref_ep"
    t.float    "ref_mgp"
    t.float    "ref_fap"
    t.float    "ref_ccffaa"
    t.integer  "desierto",      default: 0
    t.integer  "articulo",      default: 0
    t.integer  "ficha",         default: 0
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

  create_table "purchases", force: :cascade do |t|
    t.integer  "num_documento_pais"
    t.integer  "idaplicacionfuente"
    t.integer  "codigoconvocatoria"
    t.integer  "itemconvocatoria"
    t.integer  "itemconvoca_secuencia"
    t.string   "proceso"
    t.date     "fechaconvocatoria"
    t.date     "fechabuenapro"
    t.date     "fechaconsentimientobp"
    t.string   "proveedor"
    t.string   "rucproveedor"
    t.string   "tipoproveedor"
    t.string   "departamento_proveedor"
    t.string   "provincia_proveedor"
    t.string   "distrito_proveedor"
    t.string   "codigoentidad"
    t.string   "entidad"
    t.string   "objetocontractual"
    t.string   "ruc_entidad"
    t.string   "tipoentidad"
    t.string   "tipoentidadoee"
    t.string   "entidad_departamento"
    t.string   "entidad_provincia"
    t.string   "entidad_distrito"
    t.string   "modalidad"
    t.string   "modalidadoee"
    t.string   "procesoseleccion"
    t.string   "siglatipoproceso"
    t.string   "regimen"
    t.string   "itemconvoca_descripcion"
    t.string   "itemconvoca_unidadmedida"
    t.string   "item_departamento"
    t.string   "item_provincia"
    t.string   "item_distrito"
    t.string   "grupo"
    t.string   "familia"
    t.string   "clase"
    t.string   "commodity"
    t.string   "itemcubso"
    t.string   "estadoitemconvoca"
    t.string   "moneda"
    t.integer  "cantidadadjudicado"
    t.integer  "montoadjudicado"
    t.integer  "montoadjudicadosoles"
    t.string   "montoreferencial"
    t.string   "montoreferencialsoles"
    t.integer  "admin_user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["admin_user_id"], name: "index_purchases_on_admin_user_id", using: :btree
  end

  create_table "sheets", force: :cascade do |t|
    t.string   "codigo_ficha"
    t.string   "codigo_revision"
    t.date     "creada"
    t.date     "revisada"
    t.string   "descripcion_original"
    t.string   "descripcion"
    t.integer  "grupo"
    t.integer  "clase"
    t.string   "cna"
    t.string   "na"
    t.string   "soc"
    t.string   "caracteristica"
    t.integer  "vigencia"
    t.integer  "unidad_medida"
    t.integer  "admin_user_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "categoria"
    t.string   "numero"
    t.index ["admin_user_id"], name: "index_sheets_on_admin_user_id", using: :btree
  end

  create_table "students", force: :cascade do |t|
    t.integer  "employee_id"
    t.string   "centro"
    t.string   "especialidad"
    t.date     "desde"
    t.date     "hasta"
    t.string   "grado"
    t.string   "obs"
    t.integer  "admin_user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["admin_user_id"], name: "index_students_on_admin_user_id", using: :btree
    t.index ["employee_id"], name: "index_students_on_employee_id", using: :btree
  end

  create_table "suppliers", force: :cascade do |t|
    t.string   "numero_proveedor"
    t.integer  "num_documento_pais"
    t.string   "des_proveedor"
    t.string   "direccion_pais"
    t.string   "telefono_pais"
    t.string   "correo_pais"
    t.string   "pag_weeb"
    t.string   "nro_representante"
    t.string   "des_representante"
    t.string   "correo_representante"
    t.integer  "activo"
    t.string   "fec_registro"
    t.string   "mod_registro"
    t.integer  "tipo_proveedor"
    t.integer  "calificacion"
    t.string   "observacion"
    t.integer  "actividad"
    t.integer  "num_traba"
    t.integer  "admin_user_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["admin_user_id"], name: "index_suppliers_on_admin_user_id", using: :btree
  end

  add_foreign_key "activities", "admin_users"
  add_foreign_key "activities", "phases"
  add_foreign_key "agreements", "admin_users"
  add_foreign_key "agreements", "employees"
  add_foreign_key "articles", "admin_users"
  add_foreign_key "articles", "items"
  add_foreign_key "contracts", "admin_users"
  add_foreign_key "details", "admin_users"
  add_foreign_key "details", "items"
  add_foreign_key "elements", "admin_users"
  add_foreign_key "elements", "contracts"
  add_foreign_key "employees", "admin_users"
  add_foreign_key "experiences", "admin_users"
  add_foreign_key "experiences", "employees"
  add_foreign_key "families", "admin_users"
  add_foreign_key "families", "employees"
  add_foreign_key "formulas", "admin_users"
  add_foreign_key "formulas", "products"
  add_foreign_key "items", "admin_users"
  add_foreign_key "lists", "admin_users"
  add_foreign_key "movements", "admin_users"
  add_foreign_key "movements", "sheets"
  add_foreign_key "packages", "admin_users"
  add_foreign_key "packages", "contracts"
  add_foreign_key "phases", "admin_users"
  add_foreign_key "pieces", "admin_users"
  add_foreign_key "pieces", "phases"
  add_foreign_key "products", "admin_users"
  add_foreign_key "purchases", "admin_users"
  add_foreign_key "sheets", "admin_users"
  add_foreign_key "students", "admin_users"
  add_foreign_key "students", "employees"
  add_foreign_key "suppliers", "admin_users"
end
