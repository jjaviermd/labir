class AddCommentToCases < ActiveRecord::Migration[7.0]
  def change
    add_column :cases, :comment, :text
  end
end
