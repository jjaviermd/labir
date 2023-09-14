# frozen_string_literal: true

class Pathologist < ApplicationRecord
  validates :name, :last_name, presence: true
end
