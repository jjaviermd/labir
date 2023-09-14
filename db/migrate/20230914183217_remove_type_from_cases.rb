class RemoveTypeFromCases < ActiveRecord::Migration[7.0]
  def change
    remove_column :cases, :type, :integer
  end
end
