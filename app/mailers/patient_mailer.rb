class PatientMailer < ApplicationMailer
  def sample_received_email
    # @case = current_laboratory.cases.find params[:id]
    @case = params[:case]
    @patient = params[:patient]

    mail(to: @patient.email, subject: "Sample received")
  end
end
