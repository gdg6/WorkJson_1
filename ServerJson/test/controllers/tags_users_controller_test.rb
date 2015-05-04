require 'test_helper'

class TagsUsersControllerTest < ActionController::TestCase
  setup do
    @tags_user = tags_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tags_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tags_user" do
    assert_difference('TagsUser.count') do
      post :create, tags_user: { context: @tags_user.context }
    end

    assert_redirected_to tags_user_path(assigns(:tags_user))
  end

  test "should show tags_user" do
    get :show, id: @tags_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tags_user
    assert_response :success
  end

  test "should update tags_user" do
    patch :update, id: @tags_user, tags_user: { context: @tags_user.context }
    assert_redirected_to tags_user_path(assigns(:tags_user))
  end

  test "should destroy tags_user" do
    assert_difference('TagsUser.count', -1) do
      delete :destroy, id: @tags_user
    end

    assert_redirected_to tags_users_path
  end
end
