class AddRecogidoPorToItems < ActiveRecord::Migration
  def change
    add_column :items, :recogido_por, :string
  end
end
