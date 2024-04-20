# frozen_string_literal: true

# Class pathologist represent the medic professional in charge of biopsy.
class Pathologist < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Pathologist.find_each {|p| Pathologist.reset_counters(p.id, :cases)}

  has_many :cases
  belongs_to :laboratory
  validates :name, :last_name, presence: true
  has_one_attached :sign
  before_save do
    last_name.downcase!
    name.downcase!
  end

  def full_name
    "#{last_name} #{name}".titleize
  end

  def sign_report(document = pdf)
    document.bounding_box([300, document.cursor - 50], width: 150, height: 150) do
      if sign.attached?
        sign_image = StringIO.open(sign.download)
        document.image(sign_image, fit: [100, 100], position: :center)
      end
      document.text full_name.to_s, align: :center
      document.text "MP: #{registry_number}", align: :center
    end
  end
end
