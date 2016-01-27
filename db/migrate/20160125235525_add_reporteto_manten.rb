class AddReportetoManten < ActiveRecord::Migration
  def change
    add_column :mantenimientos, :reporte, :string
  end
end
