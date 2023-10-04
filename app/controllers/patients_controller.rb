class PatientsController < ApplicationController
  before_action :set_patient, only: %i[show edit update]

  def index
    @patient = Patient.find_by(dni: params[:patient_search])
  end

  def show; end

  def new
    @patient = Patient.new
    @case = @patient.cases.build
  end

  def create
    @patient = Patient.new(patient_params)
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
      redirect_to patient_path(@patient)
      flash[:success] = "#{@patient.full_name}`s information have been updated."
    else
      flash.now[:danger] = 'Something went wrong!, patient`s info was not updated.'
    end
  end

  private

  def patient_params
    params.require(:patient).permit(:dni, :f_last_name, :l_last_name, :name,
                                    :phone_number, :email, :insurance, :age,
                                    :birth_day, :gender,
                                    cases_attributes: %i[
                                      pathologist_id
                                      status
                                      macro_description
                                      micro_description
                                      diagnosis
                                      organ
                                      physician
                                      speciality
                                      protocol_number
                                      notes
                                      type_of_sample
                                    ])
  end

  def set_patient
    @patient = Patient.find params[:id]
  end
end
