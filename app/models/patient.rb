# frozen_string_literal: true

class Patient < ApplicationRecord
  after_save :calculated_age, if: :birth_day?
  validates :dni, presence: true, uniqueness: true
  validates :f_last_name, :name, presence: true
  validates :gender, numericality: { only_integer: true }
  validates :birth_day, comparison: { less_than_or_equall_to: Date.today }

  private

  def patient_params
    params.require(:patient).permit(:dni, :f_last_name, :l_last_name, :name,
                                    :phone_number, :email, :insurance, :birth_day, :age, :gender)
  end

  def calculated_age
    if age?
      age
    else
      age = Date.today.year - birth_day.year
      age -= 1 if Date.today < birth_day + age.years
    end
  end
end
