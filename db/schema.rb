# frozen_string_literal: true

ActiveRecord::Schema[7.0].define(version: 20_230_912_175_053) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'cases', force: :cascade do |t|
    t.bigint 'patient_id', null: false
    t.bigint 'pathologist_id', null: false
    t.integer 'status', default: 1
    t.text 'macro_description'
    t.text 'micro_description'
    t.text 'diagnosis'
    t.integer 'type', null: false
    t.string 'organ', null: false
    t.string 'physician'
    t.string 'speciality'
    t.string 'protocol_number', null: false
    t.string 'notes'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['pathologist_id'], name: 'index_cases_on_pathologist_id'
    t.index ['patient_id'], name: 'index_cases_on_patient_id'
    t.index ['protocol_number'], name: 'index_cases_on_protocol_number'
    t.index ['status'], name: 'index_cases_on_status'
  end

  create_table 'pathologists', force: :cascade do |t|
    t.string 'last_name', null: false
    t.string 'name', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['last_name'], name: 'index_pathologists_on_last_name'
  end

  create_table 'patients', force: :cascade do |t|
    t.string 'dni'
    t.string 'f_last_name', null: false
    t.string 'l_last_name'
    t.string 'name', null: false
    t.string 'phone_number'
    t.string 'email'
    t.string 'insurance'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'age'
    t.date 'birth_day'
    t.integer 'gender'
    t.index ['dni'], name: 'index_patients_on_dni'
    t.index ['f_last_name'], name: 'index_patients_on_f_last_name'
    t.index ['name'], name: 'index_patients_on_name'
  end

  add_foreign_key 'cases', 'pathologists'
  add_foreign_key 'cases', 'patients'
end
