# frozen_string_literal: true

Patient.delete_all
Pathologist.delete_all
Case.delete_all

puts "\n== Seeding the database with fixtures =="
system('bin/rails db:fixtures:load')
