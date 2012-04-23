class ChangeReporteTypeToItems < ActiveRecord::Migration
  def self.up
    change_column :items, :reporte, :text
  end

  def self.down
    change_column :items, :reporte, :string
  end
end
