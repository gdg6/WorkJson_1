require 'test_helper'

class GenreUserTagsControllerTest < ActionController::TestCase
  setup do
    @genre_user_tag = genre_user_tags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:genre_user_tags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create genre_user_tag" do
    assert_difference('GenreUserTag.count') do
      post :create, genre_user_tag: { title: @genre_user_tag.title }
    end

    assert_redirected_to genre_user_tag_path(assigns(:genre_user_tag))
  end

  test "should show genre_user_tag" do
    get :show, id: @genre_user_tag
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @genre_user_tag
    assert_response :success
  end

  test "should update genre_user_tag" do
    patch :update, id: @genre_user_tag, genre_user_tag: { title: @genre_user_tag.title }
    assert_redirected_to genre_user_tag_path(assigns(:genre_user_tag))
  end

  test "should destroy genre_user_tag" do
    assert_difference('GenreUserTag.count', -1) do
      delete :destroy, id: @genre_user_tag
    end

    assert_redirected_to genre_user_tags_path
  end
end
