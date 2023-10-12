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
    patient_data = [
      ['Patient name:', @patient.full_name.to_s, 'Patient DNI:', @patient.dni.to_s],
      ['Date of birth:', @patient.birth_day.to_s, 'Age:', @patient.age.to_s],
      ['Sex:', @patient.gender.to_s, 'Insurance:', @patient.insurance.to_s],
      ['Phone Number:', @patient.phone_number.to_s, 'E-mail:', @patient.email.to_s]
    ]
    case_data = [
      ['Protocol Number:', @case.protocol_number.to_s, 'Pathologist:', @pathologist.full_name.to_s],
      ['Type of sample:', @case.type_of_sample.to_s, 'Organ:', @case.organ.to_s],
      ['Physician:', @case.physician.to_s, 'Speciality:', @case.speciality.to_s]
    ]
    pdf = Prawn::Document.new
    pdf.table(patient_data, position: :center, width: 550, cell_style: { borders: %i[] }) do
      row(0).borders = [:top]
      row(-1).borders = [:bottom]
      column(0).font_style = :bold
      column(2).font_style = :bold
    end
    pdf.move_down 20
    pdf.table(case_data, position: :center, width: 550, cell_style: { borders: %i[] }) do
      row(0).borders = [:top]
      row(-1).borders = [:bottom]
      column(0).font_style = :bold
      column(2).font_style = :bold
    end
    pdf.move_down 20
    pdf.text 'Macroscopic description:'
    pdf.text @case.macro_description
    pdf.move_down 10
    pdf.text 'Microscopic description:'
    pdf.text @case.micro_description
    pdf.move_down 10
    pdf.text 'Diagnosis'
    pdf.text @case.diagnosis
    y_position = pdf.cursor - 50
    pdf.bounding_box([300, y_position], width: 150, height: 150) do
      pdf.transparent(0.5) { pdf.stroke_bounds }
      pdf.text @pathologist.full_name.to_s, align: :center
      pdf.text 'MP: 123456', align: :center
    end
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
