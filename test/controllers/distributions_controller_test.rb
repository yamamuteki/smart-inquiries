require 'test_helper'

class DistributionsControllerTest < ActionController::TestCase
  setup do
    http_login
    @distribution = distributions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:distributions)
  end

   test "should get index csv" do
    get :index, format: :csv
    assert_response :success
    assert_not_nil assigns(:distributions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create distribution" do
    assert_difference('Distribution.count') do
      post :create, distribution: { name: @distribution.name }
    end

    assert_redirected_to distributions_path
  end

  test "should not create distribution" do
    assert_no_difference('Distribution.count') do
      post :create, distribution: { name: nil }
    end

    assert flash.now[:alert]
    assert_response :success
  end

  test "should show distribution" do
    get :show, id: @distribution
    assert_response :success
  end

  test "should show distribution csv" do
    get :show, id: @distribution, format: :csv
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @distribution
    assert_response :success
  end

  test "should update distribution" do
    patch :update, id: @distribution, distribution: { name: @distribution.name }
    assert assigns(:distribution)
    assert_redirected_to distribution_path(assigns(:distribution))
  end

  test "should not update distribution" do
    patch :update, id: @distribution, distribution: { name: nil }
    assert flash.now[:alert]
    assert_response :success
  end

  test "should destroy distribution" do
    assert_difference('Distribution.count', -1) do
      delete :destroy, id: @distribution
    end

    assert_redirected_to distributions_path
  end

  test 'should send email deliver' do
    assert_difference('ActionMailer::Base.deliveries.count') do
      get :send_email, id: @distribution
    end
    assert flash.now[:notice]
  end
end
