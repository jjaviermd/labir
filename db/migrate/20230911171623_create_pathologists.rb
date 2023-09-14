# frozen_string_literal: true

class CreatePathologists < ActiveRecord::Migration[7.0]
  def change
    create_table :pathologists do |t|
      t.string :last_name, null: false
      t.string :name, null: false

      t.timestamps
    end
    add_index :pathologists, :last_name
  end
end
