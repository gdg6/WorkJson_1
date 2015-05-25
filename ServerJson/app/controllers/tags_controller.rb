class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]
  before_action :check_auth
  before_action :check_admin, only: [:create, :update, :edit, :new]

  respond_to :json, :html

  #FIXME
  def index
    render :json => Tag.select(:id, :context).where(:id => TagsToCharacter.select(:tag_id).where(:character_id=>@current_user.character_id)).load # 2 in 1 request ~= 0.5 ms
    # render :json => @current_user.character.tags.load # 3 easy commits request 0.3 0.2 0.2
  end

  def create
    @tag = Tag.new(tag_params)
    ok1 = @tag.save
    @tags_to_character = TagsToCharacter.new
    @tags_to_character.character = Character.find(params[:chraracter_id])
    @tags_to_character.tag = @tag
    ok2 = @tags_to_character.save
    @err = 'PROBLEM_SAVE' unless ok1 && ok2
    render :json => {'save_success' => ( @err.nil? ? 'SUCCESS' : 'FAIL'), 'err' => @err}
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
