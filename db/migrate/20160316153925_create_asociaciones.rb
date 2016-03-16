class CreateAsociaciones < ActiveRecord::Migration
  def change
    create_table :asociaciones do |t|
      t.string :maquina
      t.string :implemento
      t.decimal :porcentaje, precision: 10, scale: 2

      t.timestamps null: false
    end
  end
end
