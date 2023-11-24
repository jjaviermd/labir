class Template < ApplicationRecord
  belongs_to :laboratory
  validates :name, :prefix, :content, presence: true
  validates :prefix, uniqueness: {scope: [:laboratory_id, :prefix], message: "Prefix already in use"}
end
