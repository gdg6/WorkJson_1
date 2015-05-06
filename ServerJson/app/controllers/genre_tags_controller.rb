class GenreTagsController < ApplicationController
  before_action :set_genre_tag, only: [:show, :edit, :update, :destroy]
  before_action :check_auth
  before_action :check_admin

  def index
    render :json => GenreTag.all
  end

  def show
    render :json => @genre_tag
  end

  def new
    @genre_tag = GenreTag.new
  end

  def edit
  end

  def create
    @genre_tag = GenreTag.new
    @genre_tag.title = params[:genre_tag][:title]
    render :json => {'save_success' => (@genre_tag.save ? 'SUCCESS' : 'FAIL')}
  end

  def update
    @genre_tag.update(genre_tag_params)
    respond_with(@genre_tag)
  end

  def destroy
    render :json => {'destroy_success' => (@genre_tag.destroy ? 'SUCCESS' : 'FAIL')}
  end

  private
    def set_genre_tag
      @genre_tag = GenreTag.find(params[:id])
    end

    def genre_tag_params
      params.require(:genre_tag).permit(:title)
    end
end
