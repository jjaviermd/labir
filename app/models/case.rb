# frozen_string_literal: true

# Class case represent a single case for a biopsy, citology or autopsy.
class Case < ApplicationRecord
  include Documentable
  belongs_to :patient
  belongs_to :pathologist, counter_cache: true
  enum status: { gross_examination: 1,
                 histotechnology: 2,
                 microscopic_examination: 3,
                 diagnosed: 4 }
  enum type_of_sample: { biopsy: 1, citology: 2, autopsy: 3 }
  validates :status, inclusion: { in: %w[gross_examination histotechnology microscopic_examination diagnosed] }
  validates :type_of_sample, inclusion: { in: %w[biopsy citology autopsy] }
  validates :protocol_number, uniqueness: true
  validates :organ, presence: true
  scope :ordered, -> { order(updated_at: :desc) }
  before_save :set_status
  before_save do
    self.organ = organ.downcase
    self.physician = physician.downcase if physician?
    self.speciality = speciality.downcase if speciality?
  end

  def table_data
    [
      ['Protocol Number:', protocol_number.to_s, 'Pathologist:', pathologist.full_name.to_s],
      ['Type of sample:', type_of_sample.capitalize.to_s, 'Organ/Site:', organ.capitalize.to_s],
      ['Physician:', physician.capitalize.to_s, 'Speciality:', speciality.capitalize.to_s]
    ]
  end

  def description_text(document = pdf)
    document.text 'Macroscopic description:', style: :bold
    document.text macro_description
    document.move_down 10
    document.text 'Microscopic description:', style: :bold
    document.text micro_description
    document.move_down 10
    document.text 'Diagnosis', style: :bold
    document.text diagnosis
  end

  def set_status
    self.status = 'histotechnology' if macro_description? && !micro_description? && !diagnosis?
    self.status = 'diagnosed' if macro_description? && micro_description? && diagnosis?
  end
end
