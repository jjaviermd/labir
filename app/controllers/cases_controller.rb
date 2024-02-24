# frozen_string_literal: true

class CasesController < ApplicationController
  before_action :set_case, only: %i[show edit update]
  before_action :set_case_patient_pathologist, only: :sign_inform

  def index
    @cases = case params[:scope]
    when "protocol_number"
      current_laboratory.cases.joins(:patient, :pathologist).ordered.includes(:patient, :pathologist)
        .where("protocol_number LIKE ?", "%#{params[:query]}%")
    when "dni"
      current_laboratory.cases.joins(:patient, :pathologist).ordered.includes(:patient, :pathologist)
        .where("patients.dni LIKE ?", "%#{params[:query]}%")
    when "patient_last_name"
      current_laboratory.cases.joins(:patient, :pathologist).ordered.includes(:patient, :pathologist)
        .where("patients.f_last_name LIKE ?", "%#{params[:query]}%")
    when "pathologist_last_name"
      current_laboratory.cases.joins(:patient, :pathologist).ordered.includes(:patient, :pathologist)
        .where("last_name LIKE ?", "%#{params[:query]}%")
    else
      current_laboratory.cases.ordered.includes(:patient, :pathologist).all
    end
  end

  def show
  end

  def new
    @patient = current_laboratory.patients.find params[:patient_id]
    @case = @patient.cases.build
  end

  def create
    @patient = current_laboratory.patients.find case_params[:patient_id]
    @case = @patient.cases.build case_params
    if @case.save
      redirect_to case_path(@case)
      flash[:success] =
        "#{@patient.full_name}`s new case created. Protocol number: #{@case.protocol_number}."
    else
      flash.now[:danger] = "Something went wrong and case was not created."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @patient = @case.patient
  end

  def update
    if @case.update(case_params)
      respond_to do |format|
        format.html do
          redirect_to case_path(@case), success: "Case number #{@case.protocol_number} updated."
        end
        format.turbo_stream { flash.now[:success] = "Case number #{@case.protocol_number} updated." }
      end
    else
      flash.now[:danger] = "Something went wrong!, case was not updated."
      render :edit, status: :unprocessable_entity
    end
  end

  def sign_inform
    pdf = Prawn::Document.new
    # pass these line to standalone method
    # pdf.text(current_laboratory.name.to_s, align: :center, size: 16)
    # pdf.text("#{current_laboratory.address} #{current_laboratory.email}", align: :center, size: 12)
    # pdf.move_down 10
    # =======
    @laboratory.lab_header(pdf)
    @patient.pdf_table(pdf)
    @case.pdf_table(pdf)
    @case.description_text(pdf)
    @pathologist.sign_report(pdf)
    send_data(pdf.render, filename:
                            "#{@case.protocol_number}_#{@patient.full_name.split(" ").map(&:downcase).join("_")}.pdf",
      type: "application/pdf",
      disposition: "inline")
  end

  private

  def set_case
    @case = current_laboratory.cases.find params[:id]
  end

  def set_case_patient_pathologist
    @case = current_laboratory.cases.includes(:patient, :pathologist).find params[:id]
    @patient = @case.patient
    @pathologist = @case.pathologist
    @laboratory = @case.laboratory
  end

  def case_params
    params.require(:case).permit(:patient_id, :pathologist_id, :status, :macro_description,
      :micro_description, :diagnosis, :organ, :physician, :speciality, :protocol_number,
      :notes, :type_of_sample, :comment)
  end
end
