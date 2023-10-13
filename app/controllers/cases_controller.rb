# frozen_string_literal: true

class CasesController < ApplicationController
  before_action :set_case, only: %i[show edit update]
  before_action :set_case_patient_pathologist, only: :sign_inform

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
        "#{@patient.full_name}`s new case have been created. Protocol number #{@case.protocol_number}."
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

  def sign_inform
    pdf = Prawn::Document.new
    @patient.pdf_table(pdf)
    pdf.move_down 20
    @case.pdf_table(pdf)
    pdf.move_down 20
    pdf.text 'Macroscopic description:', style: :bold
    pdf.text @case.macro_description
    pdf.move_down 10
    pdf.text 'Microscopic description:', style: :bold
    pdf.text @case.micro_description
    pdf.move_down 10
    pdf.text 'Diagnosis', style: :bold
    pdf.text @case.diagnosis
    @pathologist.sign_report(pdf)
    send_data(pdf.render, filename: "#{@case.protocol_number}_#{@patient.full_name}.pdf",
                          type: 'application/pdf',
                          disposition: 'inline')
  end

  private

  def set_case
    @case = Case.find params[:id]
  end

  def set_case_patient_pathologist
    @case = Case.includes(:patient, :pathologist).find params[:id]
    @patient = @case.patient
    @pathologist = @case.pathologist
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
