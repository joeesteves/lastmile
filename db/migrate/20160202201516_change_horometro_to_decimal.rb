class ChangeHorometroToDecimal < ActiveRecord::Migration
  def change
    remove_column :mantenimientos, :horometro
    add_column :mantenimientos, :horometro, :decimal, precision: 10, scale: 2
  end
end
