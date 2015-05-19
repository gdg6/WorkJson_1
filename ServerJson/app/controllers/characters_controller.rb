class CharactersController < ApplicationController
  before_action :set_character, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
   render :json => Character.select(:id, :title).all
  end

  def show
    render :json => @character
  end

  def new
    @character = Character.new
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
