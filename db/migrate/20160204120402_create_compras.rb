class CreateCompras < ActiveRecord::Migration
  def change
    create_table :compras do |t|
      t.date :fecha
      t.string :maquina
      t.string :proveedor
      t.string :producto
      t.string :obs
      t.string :valor
      t.string :comprobante

      t.timestamps null: false
    end
  end
end
