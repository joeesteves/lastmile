class CreatePersonas < ActiveRecord::Migration
  def change
    create_table :personas do |t|
      t.string :nombre
      t.decimal :costo, precision: 10, scale: 2
      t.string :maquina
      t.decimal :porcentaje, precision: 10, scale: 2

      t.timestamps null: false
    end
  end
end
