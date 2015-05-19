module ApplicationHelper

  def session_character_list
    res = []
    Character.select(:id, :title).first(7).each{|x| res <<  [x.title, x.id] }
    return res
  end

end
