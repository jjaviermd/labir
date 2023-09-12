class AddAgeToPatient < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :age, :integer
    add_column :patients, :birth_day, :date
    add_column :patients, :gender, :integer
  end
end
