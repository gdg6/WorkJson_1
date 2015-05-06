class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    count = params[:count].to_i > 0 ? params[:count].to_i : 10
    return render :json => Tag.select(:context).where(:user_id => params[:user_id].to_i).limit(count).load if User.where(:id => params[:user_id].to_i).take
    return render :json => {}
  end

  def show
    respond_with(@tag)
  end

  def new
    @tag = Tag.new
  end

  def edit
  end

  def create
    @tag = Tag.new
    @tag.context = params[:tag][:context].to_s
    @tag.user_id = params[:tag][:user_id].to_i if User.where(:id => params[:user_id].to_i).take
    @tag.genre_tag = params[:tag][:genre_tag_id].to_i if GenreTag.where(:id => params[:genre_tag_id].to_i).take
    render :json => {'save_success' => ( @tag.save ? 'SUCCESS' : 'FAIL')}
  end

  def update
    render :json => {'update_success' => ( @tag.update(tag_params) ? 'SUCCESS' : 'FAIL')}
  end

  def destroy
    @tag.destroy
    respond_with(@tag)
  end

  private
    def set_tag
      @tag = Tag.find(params[:id])
    end

    def tag_params
      params.require(:tag).permit(:user_id, :genre_tag_id, :context)
    end
end
