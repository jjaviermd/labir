class AddCasesCountToPathologists < ActiveRecord::Migration[7.0]
  def change
    add_column :pathologists, :cases_count, :integer, default: 0, null: false
  end
end
