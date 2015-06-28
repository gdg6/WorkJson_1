class Admin::CharactersController < Admin::ApplicationController

  def create
    @character = Character.new(character_params)
    save_with_check(@character)
  end

  def update
    @character.update(character_params)
    save_with_check(@character)
  end

  def index
    @characters = Character.page(params[:page]).per(7)
  end

  private
  def set_character
    @character = Character.find(params[:id])
  end

  def character_params
    params.require(:character).permit(:title)
  end

end
