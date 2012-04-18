class AddCreatedByToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :created_by, :string
  end
end
