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
end
