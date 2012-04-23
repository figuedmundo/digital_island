class AddTecnicoToItems < ActiveRecord::Migration
  def change
    add_column :items, :tecnico, :string
  end
end
