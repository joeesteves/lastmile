class CreateLabores < ActiveRecord::Migration
  def change
    create_table :labores do |t|
      t.string :maquina
      t.decimal :superficie, precision: 10, scale: 2

      t.timestamps null: false
    end
  end
end
