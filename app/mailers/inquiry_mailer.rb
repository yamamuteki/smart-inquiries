class InquiryMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.inquiry_mailer.request_email.subject
  #
  def request_email(respondent)
    @url = "#{distributions_url}/#{respondent.uuid}"
    logger.debug @url
    mail to: respondent.email
  end
end
