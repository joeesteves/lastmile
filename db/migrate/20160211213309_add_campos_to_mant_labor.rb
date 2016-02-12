class AddCamposToMantLabor < ActiveRecord::Migration
  def change
    add_column :mantenimientos, :obs, :string
    add_column :mantenimientos, :doc, :string
    add_column :labores, :obs, :string
    add_column :labores, :doc, :string
    add_column :labores, :establecimiento, :string
    add_column :labores, :lote, :string
    add_column :compras, :doc, :string    
  end
end
