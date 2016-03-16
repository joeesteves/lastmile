class AddReportetoAsoc < ActiveRecord::Migration
  def change
    add_column :asociaciones, :reporte, :string
  end
end
