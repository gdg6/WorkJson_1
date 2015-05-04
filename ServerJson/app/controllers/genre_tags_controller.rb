class GenreTagsController < ApplicationController
  before_action :set_genre_tag, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @genre_tags = GenreTag.all
    respond_with(@genre_tags)
  end

  def show
    respond_with(@genre_tag)
  end

  def new
    @genre_tag = GenreTag.new
    respond_with(@genre_tag)
  end

  def edit
  end

  def create
    @genre_tag = GenreTag.new(genre_tag_params)
    @genre_tag.save
    respond_with(@genre_tag)
  end

  def update
    @genre_tag.update(genre_tag_params)
    respond_with(@genre_tag)
  end

  def destroy
    @genre_tag.destroy
    respond_with(@genre_tag)
  end

  private
    def set_genre_tag
      @genre_tag = GenreTag.find(params[:id])
    end

    def genre_tag_params
      params.require(:genre_tag).permit(:title)
    end
end
