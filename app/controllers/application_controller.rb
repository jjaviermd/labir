# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # before_action :authenticate_laboratory!, unless: :devise_controller?
  devise_group :client, contains: [:pathologist, :laboratory]
  before_action :authenticate_client!

  before_action :set_current_laboratory

  private

  def set_current_laboratory
    Current.laboratory = current_laboratory
  end
end
