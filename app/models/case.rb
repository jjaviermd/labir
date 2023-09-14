# frozen_string_literal: true

class Case < ApplicationRecord
  belongs_to :patient
  belongs_to :pathologist
end
