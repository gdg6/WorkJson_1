class CharactersController < ApplicationController

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
      character[:tags] = tags_context.string
      characters << character
    end
    render :json => {'characters'=>characters}
  end

end
