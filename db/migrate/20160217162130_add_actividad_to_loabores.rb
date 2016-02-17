class AddActividadToLoabores < ActiveRecord::Migration
  def change
    add_column :labores, :actividad, :string
  end
end
