require 'test_helper'

class RespondentsControllerTest < ActionController::TestCase
  setup do
    http_login
    @distribution = distributions(:one)
    @respondent = respondents(:one)
  end

  test "should get new" do
    get :new, distribution_id: @distribution
    assert_response :success
  end

  test "should create respondent" do
    assert_difference('Respondent.count') do
      post :create, distribution_id: @distribution ,emails: "test@exsample.com"
    end

    assert_redirected_to distribution_path(@distribution)
   end

  test "should get edit" do
    get :edit, distribution_id: @distribution, id: @respondent
    assert_response :success
  end

  test "should update respondent" do
    patch :update, distribution_id: @distribution, id: @respondent, respondent: { email: @respondent.email }
    assert assigns(:distribution)
    assert assigns(:respondent)
    assert_redirected_to distribution_path(assigns(:distribution))
  end

   test "should not update respondent" do
    patch :update, distribution_id: @distribution, id: @respondent, respondent: { email: nil }
    assert flash.now[:alert]
    assert_response :success
  end

  test "should destroy respondent" do
    assert_difference('Respondent.count', -1) do
      delete :destroy, distribution_id: @distribution, id: @respondent
    end

    assert_redirected_to distribution_path(assigns(:distribution))
  end
end
