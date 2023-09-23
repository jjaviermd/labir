class PatientsController < ApplicationController
  before_action :set_patient, only: %i[show edit update]

  def index; end

  def show; end

  def new; end

  def create; end

  def edit; end

  def update; end

  private

  def patient_params
    params.require(:patient).permit(:dni, :f_last_name, :l_last_name, :name,
                                    :phone_number, :email, :insurance, :age,
                                    :birth_day, :gender)
  end

  def set_patient
    @patient = Patient.find params[:id]
  end
end
