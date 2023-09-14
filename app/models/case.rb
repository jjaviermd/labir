# frozen_string_literal: true

class Case < ApplicationRecord
  belongs_to :patient
  belongs_to :pathologist
  enum status: { gross_examination: 1,
                 histotechnology: 2,
                 microscopic_examination: 3,
                 diagnosed: 4 }
  enum type: { biopsy: 1, citology: 2, autopsy: 3 }
  validates :status, numericality: { only_integer: true, in: 1..4 }
  validates :type, numericality: { only_integer: true, in: 1..3 }
  validates :protocol_number, uniqueness: true
  validates :organ, presence: true
end
