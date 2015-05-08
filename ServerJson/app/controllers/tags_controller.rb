class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]
  before_action :check_auth

  respond_to :json, :html

  def index
    count = params[:count].to_i > 0 ? params[:count].to_i : 10
    begin
      User.find(params[:user_id].to_i)
    rescue
      @err="NOT_USER"
    end
    return render :json => {"err" => "NOT_USER"} if @err != nil
    return render :json => Tag.select(:id, :context).where(:user_id => params[:user_id].to_i).limit(count).load
  end

  def show
    render :json => @tag
  end

  def new
    @tag = Tag.new
  end

  def edit
  end

  def create
    @tag = Tag.new(tag_params)
    @tag.context = params[:tag][:context].to_s
    @tag.user_id = params[:tag][:user_id].to_i if User.where(:id => params[:tag][:user_id].to_i).take
    @tag.genre_tag_id = params[:tag][:genre_tag_id].to_i if GenreTag.where(:id => params[:tag][:genre_tag_id].to_i).take
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
      params.require(:tag).permit(:context, :genre_tag_id, :user_id)
    end
end
