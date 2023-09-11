class CreateCases < ActiveRecord::Migration[7.0]
  def change
    create_table :cases do |t|
      t.references :patient, null: false, foreign_key: true
      t.references :pathologist, null: false, foreign_key: true
      t.integer :status, default: 1
      t.text :macro_description
      t.text :micro_description
      t.text :diagnosis
      t.integer :type, null: false
      t.string :organ, null: false
      t.string :physician
      t.string :speciality
      t.string :protocol_number, null: false, unique: true
      t.string :notes

      t.timestamps
    end
    add_index :cases, :protocol_number
    add_index :cases, :status
  end
end
