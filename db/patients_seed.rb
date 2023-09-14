# frozen_string_literal: true

def seed_patient
  puts 'delteting patients...'
  Patient.delete_all
  puts 'creating patient...'
  Patient.create!(dni: '94944181',
                  f_last_name: 'Perez',
                  l_last_name: 'perez',
                  name: 'Javier',
                  gender: 1,
                  phone_number: '555-555-555',
                  email: 'mail@mail.com',
                  insurance: 'colmedica',
                  birth_day: Date.new(1984, 5, 16))
  puts 'patients created'
end
