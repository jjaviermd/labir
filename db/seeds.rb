# frozen_string_literal: true

puts "\n== Deleting data =="
Case.delete_all
puts "\n== cases deleted =="
Patient.delete_all
puts "\n== Patients deleted =="
Pathologist.delete_all
puts "\n== Pathologists deleted =="
puts "\n== data deleted =="
puts "\n== Seeding the database with fixtures =="
system('bin/rails db:fixtures:load')
