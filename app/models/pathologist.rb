# frozen_string_literal: true

# Class pathologist represent the medic professional in charge of biopsy.
class Pathologist < ApplicationRecord
  has_many :cases
  validates :name, :last_name, presence: true
  has_one_attached :sign

  def full_name
    "#{last_name} #{name}"
  end

  def sign_report(document = pdf)
    document.bounding_box([300, document.cursor - 50], width: 150, height: 150) do
      sign_image = StringIO.open(sign.download)
      document.image(sign_image, fit: [100, 100], position: :center)
      document.text full_name.to_s, align: :center
      document.text 'MP: 123456', align: :center
    end
  end
end
