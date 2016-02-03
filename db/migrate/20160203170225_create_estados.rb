class CreateEstados < ActiveRecord::Migration
  def change
    create_table :estados do |t|
      t.string :referencia
      t.string :valor

      t.timestamps null: false
    end
  end
end
