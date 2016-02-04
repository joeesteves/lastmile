class CreateDepreciaciones < ActiveRecord::Migration
  def change
    create_table :depreciaciones do |t|
      t.string :maquina
      t.decimal :valor, precision: 10, scale: 2
      t.decimal :residual, precision: 10, scale: 2
      t.decimal :vidautil, precision: 10, scale: 2
      t.decimal :cuota, precision: 10, scale: 2

      t.timestamps null: false
    end
  end
end
