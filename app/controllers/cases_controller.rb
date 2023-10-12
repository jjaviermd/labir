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
    @case = Case.includes(:patient, :pathologist).find params[:id]
    @patient = @case.patient
    @pathologist = @case.pathologist
    pdf = Prawn::Document.new
    pdf.table([
                ['Patient name:', "#{@patient.full_name}", 'Patient DNI:', "#{@patient.dni}"],
                ['Date of birth', "#{@patient.birth_day}", 'Age', "#{@patient.age}"],
                ['Sex', "#{@patient.gender}", 'Insurance', "#{@patient.insurance}"],
                ['Phone Number', "#{@patient.phone_number}", 'E-mail', "#{@patient.email}"]
              ], position: :center)
    pdf.move_down 20
    pdf.table([
                ['Protocol Number:', "#{@case.protocol_number}", 'Pathologist', "#{@pathologist.full_name}"],
                ['Type of sample:', "#{@case.type_of_sample}", 'Organ', "#{@case.organ}"],
                ['Physician', "#{@case.physician}", 'Speciality', "#{@case.speciality}"]
              ], position: :center)
    pdf.move_down 20
    pdf.text 'Macroscopic description:'
    pdf.text @case.macro_description
    pdf.move_down 10
    pdf.text 'Microscopic description:'
    pdf.text @case.micro_description
    pdf.move_down 10
    pdf.text 'Diagnosis'
    pdf.text @case.diagnosis
    send_data(pdf.render, filename: "#{@case.protocol_number}_#{@patient.full_name}.pdf")
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
