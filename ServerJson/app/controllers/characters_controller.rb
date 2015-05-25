class CharactersController < ApplicationController
  before_action :check_admin, :except => [:index]
  before_action :set_character, only: [:update]


  #FIXME - very bad.
  def index
    characters = []
    c = Character.includes(:tags).select(:id, :title).first(7) # 3 query ! must be 1. Total time - 1.1ms for clear database
    #0(n^2)
    c.each do |x|
      character = {}
      character[:id] = x.id
      character[:title] = x.title
      tags_context = StringIO.new #string buffer
      for i in 0...x.tags.size - 1
        tags_context << x.tags[i].context # not good use dynamic list
        tags_context << ', '
      end
      tags_context << x.tags[-1].context # not good use dynamic list
      # x.tags.each do |t|
      #   tags_context << t.context # not good use dynamic list
      # end
      character[:tags] = tags_context.string
      characters << character
    end
    render :json => {'characters'=>characters}
    # render :json => characters[0][:tags].size
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
