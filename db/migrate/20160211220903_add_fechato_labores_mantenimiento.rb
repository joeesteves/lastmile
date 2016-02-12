class AddFechatoLaboresMantenimiento < ActiveRecord::Migration
  def change
    add_column :labores, :fecha, :date
    add_column :mantenimientos, :fecha, :date

  end
end
