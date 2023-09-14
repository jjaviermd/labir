class AddTypeOfSampleToCases < ActiveRecord::Migration[7.0]
  def change
    add_column :cases, :type_of_sample, :integer
  end
end
