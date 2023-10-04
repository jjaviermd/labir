# frozen_string_literal: true

class CasesController < ApplicationController
  before_action :set_case, only: %i[show edit update]

  def index; end

  def show; end

  def new
    @patient = Patient.find params[:patient_id]
    @case = @patient.cases.build
  end

  def create
    @patient = Patient.find case_params[:patient_id]
    @case = @patient.cases.build case_params
    if @case.save
      redirect_to case_path(@case)
      flash[:success] =
        "#{@patient.full_name}`s new case have been created.
        Protocol number #{@case.protocol_number}."
    else
      flash.now[:danger] = 'Something went wrong and case was not created.'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @patient = @case.patient
  end

  def update
    if @case.update(case_params)
      redirect_to case_path(@case)
      flash[:success] = "Case number: #{@case.protocol_number} have been updated."
    else
      flash.now[:danger] = 'Something went wrong!, case was not updated.'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_case
    @case = Case.find params[:id]
  end

  def case_params
    params.require(:case).permit(:patient_id,
                                 :pathologist_id,
                                 :status,
                                 :macro_description,
                                 :micro_description,
                                 :diagnosis,
                                 :organ,
                                 :physician,
                                 :speciality,
                                 :protocol_number,
                                 :notes,
                                 :type_of_sample)
  end
end
