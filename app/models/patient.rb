# frozen_string_literal: true

# Class patient represents a patient wich submmits biopsys and such.
class Patient < ApplicationRecord
  include Documentable
  has_many :cases
  accepts_nested_attributes_for :cases
  enum :gender, male: 1, female: 2
  validates :dni, presence: true, uniqueness: true
  validates :f_last_name, :name, presence: true
  validates :gender, inclusion: { in: %w[male female] }
  validates :birth_day, comparison: { less_than_or_equal_to: Date.today }
  before_save :calculate_age
  before_save do
    self.f_last_name = f_last_name.downcase
    self.l_last_name = l_last_name.downcase if l_last_name?
    self.name = name.downcase
    self.email = email.downcase if email?
    self.insurance = insurance.downcase if insurance?
  end

  def full_name
    # return patients full name.
    "#{f_last_name} #{l_last_name} #{name}".titleize
  end

  def table_data
    [
      ['Patient name:', full_name.to_s, 'Patient DNI:', dni.to_s],
      ['Date of birth:', birth_day.to_s, 'Age:', "#{age} Years old"],
      ['Sex:', gender.capitalize.to_s, 'Insurance:', insurance.capitalize.to_s],
      ['Phone Number:', phone_number.to_s, 'E-mail:', email.to_s]
    ]
  end

  private

  def calculate_age
    calculated_age = Date.today.year - birth_day.year
    calculated_age -= 1 if Date.today < birth_day + calculated_age.years
    self.age = calculated_age
  end
end
