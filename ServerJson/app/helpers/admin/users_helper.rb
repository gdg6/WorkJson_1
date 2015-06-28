module Admin::UsersHelper

  def get_list_characters
    Character.first(7).collect{|x| [x.title, x.id]}
  end

  def get_list_cities
    City.all.collect{|c| [c.name, c.id]}
  end

end
