class CasesController < ApplicationController
  before_action :set_case, only: %i[show edit update]

  def index; end

  def show; end

  def new; end

  def create; end

  def edit
    @patient = @case.patient
  end

  def update; end

  private

  def set_case
    @case = Case.find params[:id]
  end
end
