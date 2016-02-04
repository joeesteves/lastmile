class ChangeValorStringPorDec < ActiveRecord::Migration
  def change
    remove_column :compras, :valor
    add_column :compras, :valor, :decimal, precision: 10, scale: 2
  end
end
