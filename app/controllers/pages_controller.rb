# frozen_string_literal: true

# Class PagesController for home, about and setings
class PagesController < ApplicationController
  def home
    @cases = current_laboratory.cases.all.ordered.includes(:patient, :pathologist).limit(10)
  end

  def about; end

  def settings; end
end
