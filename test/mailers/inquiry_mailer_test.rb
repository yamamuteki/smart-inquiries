require 'test_helper'

class InquiryMailerTest < ActionMailer::TestCase
  test "request_email" do
    mail = InquiryMailer.request_email respondents(:one)
    assert_equal "アンケート入力のお願い", mail.subject
    assert_equal ["one@exsample.com"], mail.to
    assert_equal ["from@example.com"], mail.from
    mail.body.parts.each { |p| assert_match "http", p.body.to_s }
  end
end
