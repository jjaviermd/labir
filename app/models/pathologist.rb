# frozen_string_literal: true

# Class pathologist represent the medic professional in charge of biopsy.
class Pathologist < ApplicationRecord
  has_many :cases
  validates :name, :last_name, presence: true

  def full_name
    "#{last_name} #{name}"
  end
end
