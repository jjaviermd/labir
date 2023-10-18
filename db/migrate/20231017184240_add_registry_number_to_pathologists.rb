class AddRegistryNumberToPathologists < ActiveRecord::Migration[7.0]
  def change
    add_column :pathologists, :registry_number, :string, null: false
    add_index :pathologists, :registry_number
  end
end
