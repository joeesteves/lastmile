class AddReporteToPersonasDepreciacion < ActiveRecord::Migration
  def change
    add_column :personas, :reporte, :string
    add_column :depreciaciones, :reporte, :string
  end
end
