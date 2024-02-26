class PatientMailer < ApplicationMailer
  def sample_received_email
    @case = params[:case]
    @patient = params[:patient]

    mail(to: @patient.email, subject: "Sample received")
  end

  def send_report
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
    report = pdf.render_file file_name

    # attachments["attachment.pdf"] = File.read("path/to/file.pdf")
    # mail(
    #   to: @patient.email,
    #   subject: "Report avaible"
    # )

    mail(to: @patient.email, subject: "Report")
    mail.attachements[file_name] = File.read "/#{file_name}"
  end
end
