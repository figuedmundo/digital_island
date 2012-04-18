class AddRolesToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :admin,     :boolean, default: false
    add_column :usuarios, :tecnico,   :boolean, default: false
    add_column :usuarios, :vendedor,  :boolean, default: false
    add_column :usuarios, :cliente,   :boolean, default: true
  end
end
