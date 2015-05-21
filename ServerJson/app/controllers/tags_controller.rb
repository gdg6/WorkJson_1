class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]
  before_action :check_auth
  before_action :check_admin, only: [:create, :update, :edit, :new]

  respond_to :json, :html

  #FIXME
  def index
    render :json => @current_user.character.tags.load
  end

  def create
    @tag = Tag.new(tag_params)
    ok1 = @tag.save
    @tags_to_character = TagsToCharacter.new
    @tags_to_character.character = Character.find(params[:chraracter_id])
    @tags_to_character.tag = @tag
    ok2 = @tags_to_character.save
    render :json => {'save_success' => ( ok1 && ok2 ? 'SUCCESS' : 'FAIL'), 'err' => @err}
  end

  def update
    render :json => {'update_success' => ( @tag.update(tag_params) ? 'SUCCESS' : 'FAIL'), 'err' => @err}
  end

  private
    def set_tag
      @tag = Tag.find(params[:id])
    end

    def tag_params
      params.require(:tag).permit(:context)
    end
end
