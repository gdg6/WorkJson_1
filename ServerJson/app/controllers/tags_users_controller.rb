class TagsUsersController < ApplicationController
  before_action :set_tags_user, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @tags_users = TagsUser.all
    respond_with(@tags_users)
  end

  def show
    respond_with(@tags_user)
  end

  def new
    @tags_user = TagsUser.new
    respond_with(@tags_user)
  end

  def edit
  end

  def create
    @tags_user = TagsUser.new(tags_user_params)
    @tags_user.save
    respond_with(@tags_user)
  end

  def update
    @tags_user.update(tags_user_params)
    respond_with(@tags_user)
  end

  def destroy
    @tags_user.destroy
    respond_with(@tags_user)
  end

  private
    def set_tags_user
      @tags_user = TagsUser.find(params[:id])
    end

    def tags_user_params
      params.require(:tags_user).permit(:context)
    end
end
