class CharactersController < ApplicationController
  before_action :check_admin, :except => [:index]
  before_action :set_character, only: [:update]

  def index
    render :json => Character.select(:id, :title).all
  end

  def create
    @character = Character.new(character_params)
    save_with_check(@character)
  end

  def update
    @character.update(character_params)
    save_with_check(@character)
  end

  private
  def set_character
    @character = Character.find(params[:id])
  end

  def character_params
    params.require(:character).permit(:title)
  end
end
