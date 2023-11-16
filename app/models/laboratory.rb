class Laboratory < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :pathologists
  has_many :patients
  has_many :cases, through: :pathologists
  has_many :cases, through: :patients
  validates :name, :address, :phone_number, :account, presence: true
  validates :name, :account, uniqueness: true

  def lab_header(document = pdf)
    document.text(name.to_s, align: :center, size: 16)
    document.text("#{address} #{email}", align: :center, size: 12)
    document.move_down 10
  end
end
