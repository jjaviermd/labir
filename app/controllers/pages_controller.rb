# frozen_string_literal: true

# Class PagesController for home, about and setings
class PagesController < ApplicationController
  skip_before_action :authenticate_client!, only: [:welcome, :about]

  def welcome

  end
  def home
    if laboratory_signed_in?
      @cases = current_laboratory.cases.all.ordered.includes(:patient, :pathologist).limit(10)
    elsif pathologist_signed_in?
      @cases = current_pathologist.laboratory.cases.all.ordered.includes(:patient, :pathologist).limit(10)
    end
  end

  def about; end

  def settings; end
end
