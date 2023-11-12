class AddLaboratoryRefToPatients < ActiveRecord::Migration[7.0]
  def change
    add_reference :patients, :laboratory, null: false, foreign_key: true
  end
end
