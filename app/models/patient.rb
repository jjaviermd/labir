# frozen_string_literal: true

# Class patient represents a patient wich submmits biopsys and such.
class Patient < ApplicationRecord
  has_many :cases
  accepts_nested_attributes_for :cases
  enum :gender, male: 1, female: 2
  validates :dni, presence: true, uniqueness: true
  validates :f_last_name, :name, presence: true
  validates :gender, inclusion: { in: %w[male female] }
  validates :birth_day, comparison: { less_than_or_equal_to: Date.today }
  before_save :calculate_age

  def full_name
    # return patients full name.
    "#{f_last_name} #{l_last_name} #{name}"
  end

  private

  def calculate_age
    calculated_age = Date.today.year - birth_day.year
    calculated_age -= 1 if Date.today < birth_day + calculated_age.years
    self.age = calculated_age
  end
end
