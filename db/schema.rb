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

ActiveRecord::Schema.define(version: 20160316165229) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "asociaciones", force: :cascade do |t|
    t.string   "maquina"
    t.string   "implemento"
    t.decimal  "porcentaje", precision: 10, scale: 2
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "reporte"
  end

  create_table "compras", force: :cascade do |t|
    t.date     "fecha"
    t.string   "maquina"
    t.string   "proveedor"
    t.string   "obs"
    t.string   "comprobante"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.decimal  "valor",       precision: 10, scale: 2
    t.string   "reporte"
    t.string   "insumo"
    t.string   "doc"
  end

  create_table "depreciaciones", force: :cascade do |t|
    t.string   "maquina"
    t.decimal  "valor",      precision: 10, scale: 2
    t.decimal  "residual",   precision: 10, scale: 2
    t.decimal  "vidautil",   precision: 10, scale: 2
    t.decimal  "cuota",      precision: 10, scale: 2
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "reporte"
  end

  create_table "estados", force: :cascade do |t|
    t.string   "referencia"
    t.string   "valor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "labores", force: :cascade do |t|
    t.string   "maquina"
    t.decimal  "superficie",      precision: 10, scale: 2
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "reporte"
    t.string   "obs"
    t.string   "doc"
    t.string   "establecimiento"
    t.string   "lote"
    t.date     "fecha"
    t.string   "actividad"
  end

  create_table "mantenimientos", force: :cascade do |t|
    t.string   "insumo"
    t.string   "maquina"
    t.decimal  "cantidad",      precision: 10, scale: 2
    t.decimal  "costoestandar", precision: 10, scale: 2
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "reporte"
    t.decimal  "horometro",     precision: 10, scale: 2
    t.string   "obs"
    t.string   "doc"
    t.date     "fecha"
  end

  create_table "personas", force: :cascade do |t|
    t.string   "nombre"
    t.decimal  "costo",      precision: 10, scale: 2
    t.string   "maquina"
    t.decimal  "porcentaje", precision: 10, scale: 2
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "reporte"
  end

end
