class PatientMailer < ApplicationMailer
  def sample_received_email
    @case = params[:case]
    @patient = params[:patient]

    mail(to: @patient.email, subject: "Pathologic Sample received")
  end

  def send_pdf_report
    @laboratory = params[:laboratory]
    @patient = params[:patient]
    @case = params[:case]
    @pathologist = params[:pathologist]

    pdf = Prawn::Document.new
    @laboratory.lab_header(pdf)
    @patient.pdf_table(pdf)
    @case.pdf_table(pdf)
    @case.description_text(pdf)
    @pathologist.sign_report(pdf)
    file_name = "#{@case.protocol_number}_#{@patient.full_name.split(" ").map(&:downcase).join("_")}.pdf"
    pdf.render_file file_name

    attachments[file_name] = File.read file_name

    mail(to: @patient.email, subject: "Pathologic Report")
  end
end
