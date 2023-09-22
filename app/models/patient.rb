# frozen_string_literal: true

# Class patient represents a patient wich submmits biopsys and such.
class Patient < ApplicationRecord
  has_many :cases
  enum gender: {
    male: 1,
    female: 2
  }
  validates :dni, presence: true, uniqueness: true
  validates :f_last_name, :name, presence: true
  validates :gender, numericality: { only_integer: true, in: 1..2 }
  validates :birth_day, comparison: { less_than_or_equal_to: Date.today }
  before_save :calculate_age, if: :age_and_birth_day?
  # Returns true if birth_day exist while age dont.
  def age_and_birth_day?
    age.blank? && birth_day?
  end

  def full_name
    "#{f_last_name} #{l_last_name} #{name}"
  end

  private

  def patient_params
    params.require(:patient).permit(:dni, :f_last_name, :l_last_name, :name,
                                    :phone_number, :email, :insurance, :birth_day,
                                    :age, :gender)
  end

  def calculate_age
    calculated_age = Date.today.year - birth_day.year
    calculated_age -= 1 if Date.today < birth_day + calculated_age.years
    self.age = calculated_age
  end
end
