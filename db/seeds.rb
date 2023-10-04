# frozen_string_literal: true

Case.delete_all
Patient.delete_all
Pathologist.delete_all

puts "\n== Seeding the database with fixtures =="
system('bin/rails db:fixtures:load')
