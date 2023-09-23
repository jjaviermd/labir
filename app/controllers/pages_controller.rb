# frozen_string_literal: true

# Class PagesController for home, about and setings
class PagesController < ApplicationController
  def home
    @cases = Case.all.ordered.includes(:patient, :pathologist)
  end

  def about; end

  def settings; end
end
