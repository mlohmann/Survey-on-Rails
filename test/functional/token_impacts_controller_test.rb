require 'test_helper'

class TokenImpactsControllerTest < ActionController::TestCase
  setup do
    @token_impact = token_impacts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:token_impacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create token_impact" do
    assert_difference('TokenImpact.count') do
      post :create, :token_impact => { :affirm_strength => @token_impact.affirm_strength, :oppose_strength => @token_impact.oppose_strength, :token => @token_impact.token }
    end

    assert_redirected_to token_impact_path(assigns(:token_impact))
  end

  test "should show token_impact" do
    get :show, :id => @token_impact
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @token_impact
    assert_response :success
  end

  test "should update token_impact" do
    put :update, :id => @token_impact, :token_impact => { :affirm_strength => @token_impact.affirm_strength, :oppose_strength => @token_impact.oppose_strength, :token => @token_impact.token }
    assert_redirected_to token_impact_path(assigns(:token_impact))
  end

  test "should destroy token_impact" do
    assert_difference('TokenImpact.count', -1) do
      delete :destroy, :id => @token_impact
    end

    assert_redirected_to token_impacts_path
  end
end
