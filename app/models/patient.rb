# frozen_string_literal: true

class Patient < ApplicationRecord
  enum gender: {
    male: 1,
    female: 2
  }
  validates :dni, presence: true, uniqueness: true
  validates :f_last_name, :name, presence: true
  validates :gender, numericality: { only_integer: true, in: 1..2 }
  validates :birth_day, comparison: { less_than_or_equal_to: Date.today }
  # after_save :calculated_age, if: :birth_day?

  # def calculated_age
  #   if age?
  #     age
  #   else
  #     age = Date.today.year - birth_day.year
  #     age -= 1 if Date.today < birth_day + age.years
  #   end
  # end

  private

  def patient_params
    params.require(:patient).permit(:dni, :f_last_name, :l_last_name, :name,
                                    :phone_number, :email, :insurance, :birth_day, :age, :gender)
  end
end
