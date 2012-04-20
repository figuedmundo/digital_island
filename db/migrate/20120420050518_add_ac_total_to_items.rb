class AddAcTotalToItems < ActiveRecord::Migration
  def change
    add_column :items, :ac, :integer
    add_column :items, :total, :integer
  end
end
