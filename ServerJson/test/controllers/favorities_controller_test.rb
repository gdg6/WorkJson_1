require 'test_helper'

class FavoritiesControllerTest < ActionController::TestCase
  setup do
    @favority = favorities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:favorities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create favority" do
    assert_difference('Favority.count') do
      post :create, favority: { event_id: @favority.event_id, user_id: @favority.user_id }
    end

    assert_redirected_to favority_path(assigns(:favority))
  end

  test "should show favority" do
    get :show, id: @favority
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @favority
    assert_response :success
  end

  test "should update favority" do
    patch :update, id: @favority, favority: { event_id: @favority.event_id, user_id: @favority.user_id }
    assert_redirected_to favority_path(assigns(:favority))
  end

  test "should destroy favority" do
    assert_difference('Favority.count', -1) do
      delete :destroy, id: @favority
    end

    assert_redirected_to favorities_path
  end
end
