# frozen_string_literal: true

class PatientsController < ApplicationController
  before_action :set_patient, only: %i[edit update]

  def index
    @patient = current_laboratory.patients.find_by(dni: params[:patient_search])
  end

  def show
    @patient = current_laboratory.patients.includes(cases: :pathologist).find params[:id]
  end

  def new
    @patient = Patient.new
    @case = @patient.cases.build
  end

  def create
    @patient = current_laboratory.patients.build(patient_params)
    if @patient.save
      redirect_to patient_path(@patient)
      flash[:success] =
        "#{@patient.full_name}`s new case have been created.
        Protocol number #{@patient.cases.last.protocol_number}."
    else
      flash.now[:danger] = 'Something went wrong, patient and case were not created.'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @patient.update(patient_params)
      respond_to do |format|
        format.html { redirect_to patient_patth(@patient), success: "#{@patient.full_name}`s info updated." }
        format.turbo_stream { flash.now[:success] = "#{@patient.full_name}`s info updated." }
      end
    else
      flash.now[:danger] = 'Something went wrong! patient`s info was not updated.'
    end
  end

  private

  def patient_params
    params.require(:patient).permit(:dni, :f_last_name, :l_last_name, :name, :phone_number, :email, :insurance, :age,
                                    :birth_day, :gender, cases_attributes: %i[pathologist_id status macro_description
                                                                              micro_description diagnosis organ physician
                                                                              speciality protocol_number notes
                                                                              type_of_sample])
  end

  def set_patient
    @patient = current_laboratory.patients.find params[:id]
  end
end
