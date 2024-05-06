class AddActivityToPathologists < ActiveRecord::Migration[7.1]
  def change
    add_column :pathologists, :activity, :integer, default: 0
  end
end
