class InquiryMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.inquiry_mailer.request_email.subject
  #
  def request_email(respondent)
    @url = "#{inquiries_url}/#{respondent.uuid}/edit"
    logger.debug @url
    mail to: respondent.email, subject: 'アンケート入力のお願い'
  end
end
