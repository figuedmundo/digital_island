class AddTrabajoRepuestoToItems < ActiveRecord::Migration
  def change
    add_column :items, :trabajo, :integer
    add_column :items, :repuesto, :integer
  end
end
