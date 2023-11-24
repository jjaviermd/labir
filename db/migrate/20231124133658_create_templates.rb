class CreateTemplates < ActiveRecord::Migration[7.0]
  def change
    create_table :templates do |t|
      t.references :laboratory, null: false, foreign_key: true
      t.string :type
      t.string :prefix
      t.string :name
      t.text :text

      t.timestamps
    end
    add_index :templates, [:laboratory_id, :type, :prefix], unique: true
    add_index :templates, :prefix
  end
end
