class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :usuario_id
      t.string :detalle
      t.string :reporte
      t.string :estado

      t.timestamps
    end
    add_index :items, [:usuario_id, :created_at]
  end
end
