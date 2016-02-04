class AddReporteToCompras < ActiveRecord::Migration
  def change
    add_column :compras, :reporte, :string
  end
end
