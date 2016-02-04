class ChangeProductoToInsumoInCompras < ActiveRecord::Migration
  def change
    remove_column :compras, :producto
    add_column :compras, :insumo, :string
  end
end
