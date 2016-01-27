class CreateMantenimientos < ActiveRecord::Migration
  def change
    create_table :mantenimientos do |t|
      t.string :insumo
      t.string :maquina
      t.integer :horometro
      t.decimal :cantidad, precision: 10, scale: 2
      t.decimal :costoestandar, precision: 10, scale: 2

      t.timestamps null: false
    end
  end
end
