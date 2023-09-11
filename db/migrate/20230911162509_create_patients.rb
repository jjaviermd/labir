# frozen_string_literal: true

class CreatePatients < ActiveRecord::Migration[7.0]
  def change
    create_table :patients do |t|
      t.string :dni, unique: true
      t.string :f_last_name, null: false
      t.string :l_last_name
      t.string :name, null: false
      t.string :phone_number
      t.string :email
      t.string :insurance

      t.timestamps
    end
    add_index :patients, :dni
    add_index :patients, :f_last_name
    add_index :patients, :name
  end
end
