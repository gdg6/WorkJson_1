class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]
  before_action :check_auth
  before_action :check_admin, only: [:create, :update, :destroy, :edit, :new]

  respond_to :json, :html

  #FIXME
  def index
    count = params[:count].to_i > 0 ? params[:count].to_i : 10
    render :json => Tag.select(:id, :context).where("id IN (?)", TagsToCharacter.select(:tag_id).where(:character_id => @current_user.character_id)).load
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
    @tag = Tag.new
    @tag.context = params[:tag][:context].to_s
    ok1 = @tag.save
    @tags_to_character = TagsToCharacter.new
    @tags_to_character.character = Character.find(params[:chraracter_id])
    @tags_to_character.tag = @tag
    ok2 = @tags_to_character.save
    render :json => {'save_success' => ( ok1 && ok2 ? 'SUCCESS' : 'FAIL'), 'err' => @err}
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
      params.require(:tag).permit(:context)
    end
end
