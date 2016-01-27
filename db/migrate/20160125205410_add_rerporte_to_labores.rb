class AddRerporteToLabores < ActiveRecord::Migration
  def change
    add_column :labores, :reporte, :string
  end
end
