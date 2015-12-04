require 'test_helper'

class InquiriesControllerTest < ActionController::TestCase
  setup do
    @respondent = respondents(:one)
    @respondent_without_inqury = respondents(:two)
  end

  test "should get show" do
    get :show, uuid: @respondent.uuid
    assert_response :success
  end

  test "should create inquiry" do
    assert_difference('Inquiry.count') do
      post :create, uuid: @respondent_without_inqury.uuid, content: { q1: '1', q2: 'test_q2', q3: 'test_q3' }
    end

    assert_redirected_to inquiry_path(@respondent_without_inqury.uuid)
  end

  test "should not create inquiry" do
    assert_no_difference('Inquiry.count') do
      post :create, uuid: @respondent.uuid
    end

    assert_redirected_to inquiry_path(@respondent.uuid)
  end

  test "should get edit" do
    get :edit, uuid: @respondent_without_inqury.uuid
    assert_response :success
  end

  test "should not get edit" do
    get :edit, uuid: @respondent.uuid
    assert_redirected_to inquiry_path(@respondent.uuid)
  end
end
