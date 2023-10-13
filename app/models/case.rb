# frozen_string_literal: true

# Class case represent a single case for a biopsy, citology or autopsy.
class Case < ApplicationRecord
  include Documentable
  belongs_to :patient
  belongs_to :pathologist
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

  def table_data
    [
      ['Protocol Number:', protocol_number.to_s, 'Pathologist:', pathologist.full_name.to_s],
      ['Type of sample:', type_of_sample.to_s, 'Organ/Site:', organ.to_s],
      ['Physician:', physician.to_s, 'Speciality:', speciality.to_s]
    ]
  end

  # def pdf_table(document = pdf)
  #   document.table(table_data, position: :center, width: 550, cell_style: { borders: %i[] }) do
  #     row(0).borders = [:top]
  #     row(-1).borders = [:bottom]
  #     column(0).font_style = :bold
  #     column(2).font_style = :bold
  #   end
  # end

  def set_status
    self.status = 'histotechnology' if macro_description? && !micro_description? && !diagnosis?
    self.status = 'diagnosed' if macro_description? && micro_description? && diagnosis?
  end
end
