class Template < ApplicationRecord
  belongs_to :laboratory
  validates :prefix, length: {maximum: 10}
  validates :name, :prefix, :text, presence: true
  validates :prefix, uniqueness: {scope: [:laboratory_id, :type], message: "already in use"}
end
