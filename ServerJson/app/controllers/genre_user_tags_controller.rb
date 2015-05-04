class GenreUserTagsController < ApplicationController
  before_action :set_genre_user_tag, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @genre_user_tags = GenreUserTag.all
    respond_with(@genre_user_tags)
  end

  def show
    respond_with(@genre_user_tag)
  end

  def new
    @genre_user_tag = GenreUserTag.new
    respond_with(@genre_user_tag)
  end

  def edit
  end

  def create
    @genre_user_tag = GenreUserTag.new(genre_user_tag_params)
    @genre_user_tag.save
    respond_with(@genre_user_tag)
  end

  def update
    @genre_user_tag.update(genre_user_tag_params)
    respond_with(@genre_user_tag)
  end

  def destroy
    @genre_user_tag.destroy
    respond_with(@genre_user_tag)
  end

  private
    def set_genre_user_tag
      @genre_user_tag = GenreUserTag.find(params[:id])
    end

    def genre_user_tag_params
      params.require(:genre_user_tag).permit(:title)
    end
end
