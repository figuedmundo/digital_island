class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.string :nombre
      t.string :apellido
      t.string :email
      t.string :telefono

      t.timestamps
    end

    add_index :usuarios, :email, unique: true
  end
end
