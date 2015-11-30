# Preview all emails at http://localhost:3000/rails/mailers/inquiry_mailer
class InquiryMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/inquiry_mailer/request_email
  def request_email
    InquiryMailer.request_email
  end

end
