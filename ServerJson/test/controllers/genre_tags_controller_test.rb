require 'test_helper'

class GenreTagsControllerTest < ActionController::TestCase
  setup do
    @genre_tag = genre_tags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:genre_tags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create genre_tag" do
    assert_difference('GenreTag.count') do
      post :create, genre_tag: { title: @genre_tag.title }
    end

    assert_redirected_to genre_tag_path(assigns(:genre_tag))
  end

  test "should show genre_tag" do
    get :show, id: @genre_tag
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @genre_tag
    assert_response :success
  end

  test "should update genre_tag" do
    patch :update, id: @genre_tag, genre_tag: { title: @genre_tag.title }
    assert_redirected_to genre_tag_path(assigns(:genre_tag))
  end

  test "should destroy genre_tag" do
    assert_difference('GenreTag.count', -1) do
      delete :destroy, id: @genre_tag
    end

    assert_redirected_to genre_tags_path
  end
end
