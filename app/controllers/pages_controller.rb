# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    @cases = Case.all.ordered
  end

  def about; end

  def settings; end
end
