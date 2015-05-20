class CharactersController < ApplicationController
  before_action :check_admin, :except => [:create, :update]
  before_action :set_character, only: [:update]

  def index
   render :json => Character.select(:id, :title).all
  end

  def create
    @character = Character.new
    @character.title = params[:character][:title].to_s
    save_with_check(@character)
  end

  def update
    @character.title = params[:title] unless params[:title].nil?
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
